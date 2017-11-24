import Foundation
import MovieDBCore

class SearchResultsDataSourceProvider: PagingNetworkDataSourceProviding {
    var headerTitle = ""
    var emptyDataSourceInfoString = NSLocalizedString("No results", comment: "Needs comment")
    var loadingDataSourceInfoString = NSLocalizedString("Loading…", comment: "Needs comment")
    var errorHandler: DataSourceProvidingErrorHandler?
    var updateHandler: DataSourceProvidingUpdateHandler?
    var prepareHandler: DataSourceProvidingPreparationHandler?
    var items: [DataSourceItemProtocol] = []
    var totalItemCount: Int = 0
    
    var task: URLSessionDataTaskProtocol?
    
    var page: Int = 0
    var totalPageCount: Int = 0
    
    var request: MovieSearchRequest = MovieSearchRequest(query: "")
    
    func update() {
        prepareHandler?()
        let resource = MovieSearchContainer.resource(with: request)
        task = APIClient.shared.dataTask(resource: resource) { [weak self] result in
            guard var strongSelf = self else { return }

            switch result {
            case let .success(container):
                strongSelf.page = container.page
                strongSelf.totalPageCount = container.totalPageCount
                strongSelf.totalItemCount = container.totalResultCount
                strongSelf.append(items: container.results)
                
                if strongSelf.page == 1 {
                    strongSelf.updateHandler?()
                }
            case let .failure(error):
                strongSelf.errorHandler?(error)
            }
        }
        
        task?.resume()
    }
    
    func loadNextPageIfNeeded() {
        guard page < totalPageCount else { return }
        
        request.page += 1
        update()
    }
}
