import Foundation
import MovieDBCore

class SearchResultsDataSourceProvider: PagingNetworkDataSourceProviding {
    
    var headerTitle = ""
    var emptyDataSourceInfoString = NSLocalizedString("No results", comment: "Needs comment")
    var loadingDataSourceInfoString = NSLocalizedString("Loading…", comment: "Needs comment")
    
    var errorHandler: DataSourceProvidingErrorHandler?
    var didUpdate: DataSourceProvidingDidUpdateHandler?
    var willUpdate: DataSourceProvidingWillUpdateHandler?
    
    var items: [DataSourceItemProtocol] = []
    var totalItemCount: Int = 0
    
    var task: URLSessionDataTaskProtocol?
    
    var page: Int = 0
    var totalPageCount: Int = 0
    
    var request: MovieSearchRequest = MovieSearchRequest(query: "")
    
    func flush() {
        if allowsFlush {
            items = []
            totalItemCount = items.count
        }
        didUpdate?()
    }
    
    func update() {
        willUpdate?()

        load(page: 1) {
            self.didUpdate?()
        }
    }
    
    func load(page: Int, completion: @escaping () -> Void) {
        request.page = page
        let resource = MovieSearchContainer.resource(with: request)
        task = APIClient.shared.dataTask(resource: resource) { [weak self] result in
            guard var strongSelf = self else { return }
            
            switch result {
            case let .success(container):
                strongSelf.page = container.page
                strongSelf.totalPageCount = container.totalPageCount
                strongSelf.totalItemCount = container.totalResultCount
                strongSelf.append(items: container.results)
                
                completion()
            case let .failure(error):
                strongSelf.errorHandler?(error)
            }
        }
        task?.resume()
    }
    
    func loadNextPageIfNeeded() {
        guard page < totalPageCount else { return }
        
        load(page: request.page + 1) {
            
        }
    }
    
}
