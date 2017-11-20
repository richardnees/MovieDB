import UIKit
import MovieDBCore

public class ImageView: UIImageView {
    var dataTask: URLSessionDataTask?
    
    public func cancel() {
        dataTask?.cancel()
        image = nil
    }
    
    public func load(url: URL, completion: @escaping (Error?) -> Void) {
        
        let imageDataResource = Resource<UIImage>(url: url) { data -> UIImage? in
            return UIImage(data: data)
        }
        
        dataTask = ResourceLoader().dataTask(resource: imageDataResource) { [weak self] result in
            switch result {
            case let .success(image):
                DispatchQueue.main.async {
                    self?.image = image
                }
                completion(nil)
            case let .failure(error):
                DispatchQueue.main.async {
                    self?.image = nil
                }
                completion(error)
            }
        }
        
        dataTask?.resume()
    }
}
