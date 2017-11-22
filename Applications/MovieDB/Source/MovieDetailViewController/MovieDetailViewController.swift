import UIKit
import MovieDBCore
import MovieDBKit

class MovieDetailViewController: UIViewController {

    @IBOutlet var posterImageView: ImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!

    var item: DataSourceDisplayableItem? {
        didSet {
            guard let movie = item as? Movie else { return }
            titleLabel.text = movie.title
            overviewLabel.text = movie.overview

            if let releaseDate = movie.releaseDate {
                releaseDateLabel.text = MovieSearchResultCell.releaseDateFormatter.string(from: releaseDate)
                releaseDateLabel.isHidden = false
            } else {
                releaseDateLabel.isHidden = true
            }

            if
                let posterPathComponent = movie.posterPathComponent,
                let posterURL = Poster(path: posterPathComponent).url(for: .medium) {
                self.posterImageView.load(url: posterURL) { error in
                    // FIXME: Handle error
                }
            }
        }
    }
}
