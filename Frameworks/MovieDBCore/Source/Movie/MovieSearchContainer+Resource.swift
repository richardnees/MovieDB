import Foundation

extension MovieSearchContainer {
        
    public static func resource(with request: MovieSearchRequest) -> Resource<MovieSearchContainer> {
        return Resource<MovieSearchContainer>(url: request.url) { data in
            let decoder = JSONDecoder()
            do {
                let decoded = try decoder.decode(MovieSearchContainer.self, from: data)
                return Result.success(decoded)
            } catch let error {
                return Result.failure(error)
            }
        }
    }
}
