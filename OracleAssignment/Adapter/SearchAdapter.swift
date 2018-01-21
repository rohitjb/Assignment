import Foundation
import UIKit

class SearchAdapter: NSObject, UISearchBarDelegate {    
    
    private var applySearch: ((String) -> Void)?
    private var reload: (() -> ())?
    
    func attachListener(listener: BookListActionListener) {
        applySearch = listener.search
        reload = listener.reloadWithDefaultValue
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        reload?()
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        applySearch?(searchText)
    }
}
