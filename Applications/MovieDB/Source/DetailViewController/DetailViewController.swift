import UIKit
import MovieDBCore
import MovieDBKit

class DetailViewController: UIViewController {

    // MARK: - IB Outlets

    @IBOutlet var effectView: UIVisualEffectView!
    @IBOutlet var posterImageView: PosterImageView!
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    
    // MARK: - Properties

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

            if
                let posterPathComponent = movie.posterPathComponent,
                let posterURL = Poster(path: posterPathComponent).url(for: .medium) {
                self.posterImageView.load(url: posterURL) { error in
                    DispatchQueue.main.sync {
                        self.backgroundImageView.image = self.posterImageView.image
                    }
                }
            } else {
                posterImageView.image = UIImage(named: "MoviePosterPlaceHolder")
            }
        }
    }
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        effectView.layer.masksToBounds = true
        effectView.layer.cornerRadius = 10.0
    }
    
}
