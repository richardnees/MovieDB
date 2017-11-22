import Foundation

extension MovieSearchContainer {
        
    public static func search(with request: MovieSearchRequest) -> Resource<MovieSearchContainer> {
        return Resource<MovieSearchContainer>(url: request.url, decode: { data in
            let decoder = JSONDecoder()
            do {
                let decoded = try decoder.decode(MovieSearchContainer.self, from: data)
                return Result.success(decoded)
            } catch let error {
                return Result.failure(error)
            }
        })
    }
}
