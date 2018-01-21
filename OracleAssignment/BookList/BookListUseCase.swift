import Foundation

typealias FetchCompletionHandler = ([Book]?, Error?) -> ()
protocol BookListUseCase {
    func loadBookList(date: Date, completionHandler: @escaping FetchCompletionHandler)
}

class DefaultBookListUseCase: BookListUseCase {
    private let dataSource: BookListDataSource
    private let operationQueue: OperationQueue
    
    init(dataSource: BookListDataSource, operationQueue: OperationQueue = OperationQueue()) {
        self.dataSource = dataSource
        self.operationQueue = operationQueue
    }
    
    func loadBookList(date: Date, completionHandler: @escaping FetchCompletionHandler) {
        dataSource.loadData(date: date) { (json, error) in
            
            do {
                guard let json = json else {
                    completionHandler(nil, error)
                    return
                }
                let result = try Result(json: json)
                let books = result.lists.flatMap { $0.books }
                completionHandler(books, nil)
            } catch {
                completionHandler(nil, error)
            }
        }
    }
}
