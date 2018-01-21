import Foundation
import UIKit

class BookListAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {
    private (set) var components = [Book]()

    func updateViewState(with books: [Book]) {
        components = books
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return components.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = BookTableViewCell(style: .default, reuseIdentifier: "Cell")
        let book = components[indexPath.row]
        cell.upateWithBook(book: book)
        return cell
    }
}
