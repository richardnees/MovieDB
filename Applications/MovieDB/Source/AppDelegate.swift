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
        
        // WORKAROUND:
        // We need to set this in code due to a bug with the storyboard in iOS 11
        // https://stackoverflow.com/questions/45144324/hide-large-title-when-scrolling-up
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(named: "navigationBarTitle") ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(named: "navigationBarTitle") ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ]

        UISearchBar.appearance().tintColor = tintColor
        
        UITextField.appearance().keyboardAppearance = .default
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue : UIColor(named: "searchBarTitle") ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ]

        UIWindow.appearance().backgroundColor = UIColor(named: "windowBackground")
        UIWindow.appearance().tintColor = tintColor
    }
}
