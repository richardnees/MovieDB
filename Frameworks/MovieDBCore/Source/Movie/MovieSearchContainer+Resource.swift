import Foundation

extension MovieSearchContainer {
    public static func search(request: MovieSearchRequest) -> Resource<MovieSearchContainer> {
        return Resource<MovieSearchContainer>(url: request.url, decode: { data in
            let decoder = JSONDecoder()
            do {
                let decoded = try decoder.decode(MovieSearchContainer.self, from: data)
                return decoded
            } catch let error {
                // FIXME:
            }
            return nil
        })
    }
}
