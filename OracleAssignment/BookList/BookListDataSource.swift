import Foundation

protocol BookListDataSource {
    func loadData(date: Date, dataCompletionHandler: @escaping ((JSON?, Error?) -> ()))
}

class DefaultBookListDataSource: BookListDataSource {
    private let apiService: APIService
    
    init(apiService: APIService = HTTPAPIService()) {
        self.apiService = apiService
    }

    func loadData(date: Date, dataCompletionHandler: @escaping ((JSON?, Error?) -> ())) {
        apiService.fetch(for: date, completionHandler: dataCompletionHandler)
    }
}
