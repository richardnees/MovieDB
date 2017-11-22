import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setupAppearance()
        
        return true
    }
}

extension AppDelegate {
    func setupAppearance() {

        let tintColor = UIColor(named: "tint")
        
        UINavigationBar.appearance().barStyle = .default
        // WORKAROUND:
        // We need to set this in code due to a bug with the storyboard in iOS 11
        // https://stackoverflow.com/questions/45144324/hide-large-title-when-scrolling-up
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().tintColor = tintColor

        UISearchBar.appearance().barStyle = .black
        UISearchBar.appearance().tintColor = tintColor
        
        UITextField.appearance().keyboardAppearance = .default
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue : UIColor(named: "searchBarTitle") ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ]

        UIWindow.appearance().backgroundColor = UIColor(named: "windowBackground")
        UIWindow.appearance().tintColor = tintColor
    }
}
