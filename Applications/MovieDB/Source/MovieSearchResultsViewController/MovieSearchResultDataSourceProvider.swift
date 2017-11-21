import Foundation
import MovieDBCore

class MovieSearchResultDataSourceProvider: PagingDataSourceProviding {
    var headerTitle = ""
    var errorHandler: DataSourceProvidingErrorHandler?
    var updateHandler: DataSourceProvidingUpdateHandler?
    var items: [DataSourceDisplayableItem] = []
    var totalItemCount: Int = 0
    
    var task: URLSessionDataTask?
    
    var page: Int = 0
    var totalPageCount: Int = 0
    
    var request: MovieSearchRequest = MovieSearchRequest(query: "")
    
    func update() {
        let resource = MovieSearchContainer.search(request: request)
        task = ResourceLoader().dataTask(resource: resource) { [weak self] result in
            guard var strongSelf = self else { return }

            switch result {
            case let .success(container):
                strongSelf.page = container.page
                strongSelf.totalPageCount = container.totalPageCount
                strongSelf.totalItemCount = container.totalResultCount
                strongSelf.append(items: container.results)
                
                if strongSelf.page == 1 {
                    // FIXME: Maybe have an "initial load" closure?
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
