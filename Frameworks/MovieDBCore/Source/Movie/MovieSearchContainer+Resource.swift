import Foundation

extension MovieSearchContainer {
    public static func search(request: MovieSearchRequest) throws -> Resource<MovieSearchContainer> {
        return Resource<MovieSearchContainer>(url: request.url, dateDecodingStrategy: API.dateDecodingStrategy) { (data, decoder) -> MovieSearchContainer in
            return try decoder.decode(MovieSearchContainer.self, from: data)
        }
    }
}
