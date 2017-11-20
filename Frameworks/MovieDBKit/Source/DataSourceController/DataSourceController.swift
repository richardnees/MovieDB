import UIKit
import MovieDBCore

public typealias DataSourceControllerUpdateHandler = (() -> Void)
public typealias DataSourceControllerCancellationHandler = (() -> Void)
public typealias DataSourceControllerErrorHandler = ((Error) -> Void)

public class DataSourceController: NSObject {
    
    public weak var tableView: UITableView? {
        didSet {
            guard let tableView = tableView else { return }
            
            let nib = UINib(nibName: String(describing: DataSourceLoadingCell.self), bundle: Bundle(for: DataSourceLoadingCell.self))
            tableView.register(nib, forCellReuseIdentifier: String(describing: DataSourceLoadingCell.self))
            
            tableView.dataSource = self
            tableView.prefetchDataSource = self

        }
    }
    
    public var dataTask: URLSessionDataTask?
    
    public var container: ResourceContainer?
    
    public var request: MovieSearchRequest? {
        didSet {
            container = nil
        }
    }
    
    public var updateHandler: DataSourceControllerUpdateHandler?
    public var cancellationHandler: DataSourceControllerCancellationHandler?
    public var errorHandler: DataSourceControllerErrorHandler?
    
    public func resume() {
        guard let request = request else {
            // FIXME: Handle error
            assertionFailure()
            return
        }
        
        guard let updateHandler = updateHandler else {
            // FIXME: Handle error
            assertionFailure()
            return
        }
        
        guard let errorHandler = errorHandler else {
            // FIXME: Handle error
            assertionFailure()
            return
        }
        
        let resource = MovieSearchContainer.search(request: request)
        
        dataTask = ResourceLoader().dataTask(resource: resource) { result in
            switch result {
            case let .success(container):
                if var currentContainer = self.container {
                    currentContainer.page = container.page
                    currentContainer.accumulatedResults += (container.results as [Codable])
                    self.container = currentContainer
                } else {
                    self.container = container
                    self.container?.accumulatedResults = container.results
                    updateHandler()
                }
            case let .failure(error):
                errorHandler(error)
            }
        }
        
        dataTask?.resume()
    }
    
    public func cancel() {
        guard let dataTask = dataTask else {
            // FIXME: Handle error
            return
        }
        
        guard let cancellationHandler = cancellationHandler else {
            // FIXME: Handle error
            assertionFailure()
            return
        }
        
        dataTask.cancel()
        container = nil
        tableView?.reloadData()
        cancellationHandler()
    }
}

extension DataSourceController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return container?.totalResults ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let accumulatedCount = container?.accumulatedResults.count,
            indexPath.row < accumulatedCount,
            let item = container?.accumulatedResults[indexPath.row] as? DataSourceDisplayableItem else {
                return tableView.dequeueReusableCell(withIdentifier: String(describing: DataSourceLoadingCell.self), for: indexPath) 
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: item.cellIdentifier, for: indexPath)
        if var cell = cell as? DataSourceDisplayableCell {
            cell.item = item
        }
        return cell as UITableViewCell
    }
}

extension DataSourceController: UITableViewDataSourcePrefetching {
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard
            let request = request,
            let container = container,
            request.page < container.totalPages
        else {
            return
        }
        
        request.page += 1

        resume()
    }
}
