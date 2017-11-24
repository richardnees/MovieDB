import Foundation
import MovieDBCore
import MovieDBKit

class SearchResultCell: UITableViewCell, DataSourceCellProtocol {
    
    @IBOutlet var posterImageView: PosterImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
        
    var item: DataSourceItemProtocol? {
        didSet {
            guard let movie = item as? Movie else { return }
            titleLabel.text = movie.title
            overviewLabel.text = movie.overview
            
            if let releaseDate = movie.releaseDate {
                releaseDateLabel.text = SearchResultCell.releaseDateFormatter.string(from: releaseDate)
                releaseDateLabel.isHidden = false
            } else {
                releaseDateLabel.isHidden = true
            }
            
            posterImageView.layer.masksToBounds = true
            posterImageView.layer.cornerRadius = 10.0

            if
                let posterPathComponent = movie.posterPathComponent,
                let posterURL = Poster(path: posterPathComponent).url(for: .medium) {
                self.posterImageView.load(url: posterURL) { error in
                    // FIXME: Handle error
                }
            } else {
                posterImageView.image = UIImage(named: "MoviePosterPlaceHolder")
            }
        }
    }
    
    override func prepareForReuse() {
        posterImageView.cancel()
        titleLabel.text = nil
        overviewLabel.text = nil
        releaseDateLabel.text = nil
    }
    
}

extension SearchResultCell {
    
    static let releaseDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
}

