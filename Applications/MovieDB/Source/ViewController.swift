import UIKit
import MovieDBCore

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            let request = MovieSearchRequest(query: "batman", page: 1)
            let resource = try MovieSearchContainer.search(request: request)
            ResourceLoader().load(resource: resource) { result in
                switch result {
                case let .success(container):
                    print(container)
                case let .failure(error):
                    print(error)
                }
            }
        } catch let error {
            print(error)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

