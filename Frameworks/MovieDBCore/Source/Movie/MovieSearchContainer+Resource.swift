import Foundation

extension MovieSearchContainer {
    public static func search(request: MovieSearchRequest) -> Resource<MovieSearchContainer> {
        return Resource<MovieSearchContainer>(url: request.url, decode: { (data, decoder) in
            do {
                return try decoder.decode(MovieSearchContainer.self, from: data)
            } catch let error {
                // FIXME: Handle error
            }
            return nil
        })
    }
}
