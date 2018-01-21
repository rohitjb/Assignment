import Foundation

public struct Book {
    var title: String = ""
    var publisher: String = ""
    var description: String = ""
    
    init(json: JSON) throws {
        self.title = json["title"] as? String ?? ""
        self.publisher = json["publisher"] as? String ?? ""
        self.description = json["description"] as? String ?? ""
    }
}

extension Book: Equatable {
    public static func ==(lhs: Book, rhs: Book) -> Bool {
        return lhs.title == rhs.title && lhs.description == rhs.description && lhs.publisher == rhs.publisher
    }
}
