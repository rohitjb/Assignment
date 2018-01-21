import Foundation
import  UIKit

class BookListNavigator {
    lazy var navController: UINavigationController = {
        let bookListViewController = BookListViewController(navigator: self)
        let navController = UINavigationController(rootViewController: bookListViewController)
        navController.navigationBar.isTranslucent = false
        navController.navigationBar.tintColor = UIColor.orange
        return navController
    }()
}
