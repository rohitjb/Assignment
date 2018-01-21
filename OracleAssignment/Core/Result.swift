import Foundation

struct Result {
    var lists: [List] = [List]()
    
    init(json: JSON) throws {
        guard let result = json["results"] as? [String: Any],
            let lists = result["lists"] as? [[String: Any]] else { throw ParsingError.parsingError }
        self.lists = try lists.flatMap({ (dict) -> List in
            return try List(json: dict)
        })
    }
}
