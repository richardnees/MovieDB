import Foundation

public struct Movie: Codable {
    public let voteCount: Int
    public let id: Int
    public let isVideo: Bool
    public let voteAverage: Decimal
    public let title: String
    public let popularity: Decimal
    public let posterPathComponent: String
    public let originalLanguage: String
    public let originalTitle: String
    public let genreIDs: [Int]
    public let backdropPathComponent: String
    public let isAdult: Bool
    public let overview: String
    public let releaseDate: String

    private enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case id = "id"
        case isVideo = "video"
        case voteAverage = "vote_average"
        case title = "title"
        case popularity = "popularity"
        case posterPathComponent = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDs = "genre_ids"
        case backdropPathComponent = "backdrop_path"
        case isAdult = "adult"
        case overview = "overview"
        case releaseDate = "release_date"
    }
}
