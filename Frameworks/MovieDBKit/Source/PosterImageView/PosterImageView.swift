import UIKit
import MovieDBCore

/// Used to load Poster Images from a URL
public class PosterImageView: UIImageView {
    
    /// Task used to load image data
    private var dataTask: URLSessionDataTaskProtocol?
    
    /// Called to cancel loading
    public func cancel() {
        dataTask?.cancel()
        image = nil
    }
    
    /// Loads image from `URL`
    ///
    /// - parameter url:        Image URL
    /// - parameter completion: An `Error` if loading fails
    public func load(url: URL, completion: @escaping (Error?) -> Void) {

        let imageDataResource = Resource<UIImage>(url: url) { data -> Result<UIImage> in
            if let image = UIImage(data: data) {
                return Result.success(image)
            } else {
                return Result.failure(APIClient.ParsingError.imageCreationFailed)
            }
        }
        
        dataTask = APIClient.shared.dataTask(resource: imageDataResource) { [weak self] result in
            guard let strongSelf = self else { return }

            switch result {
            case let .success(image):
                DispatchQueue.main.async {
                    strongSelf.image = image
                }
                completion(nil)
            case let .failure(error):
                DispatchQueue.main.async {
                    strongSelf.image = nil
                }
                completion(error)
            }
        }
        
        dataTask?.resume()
    }
}
