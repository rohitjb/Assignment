import Foundation

enum ParsingError: Error {
    case parsingError
}

public struct List {
    var listId: String = ""
    var listName: String = ""
    var books: [Book] = [Book]()
    
    init(json: JSON) throws {        
        self.listId = json["list_id"] as? String ?? ""
        self.listName = json["list_name"] as? String ?? ""
        
        guard let books = json["books"] as? [[String: Any]] else { throw ParsingError.parsingError }
        self.books = try books.flatMap({ (dict) -> Book in
            return try Book(json: dict)
        })
    }
}
