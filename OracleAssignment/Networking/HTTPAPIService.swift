import Foundation
import UIKit

struct APIParamConstants {
    static let key = "76363c9e70bc401bac1e6ad88b13bd1d"
    static let baseURL = "https://api.nytimes.com/svc/books/v2/lists/overview.json"
}

enum NetworkError: Error {
    case unAvailabilityInternetConnectivity
    case invalidJsonObject
    case other
}

protocol APIService: class {
    func fetch(for date: Date, completionHandler: @escaping DataCompletionHandler)
}

typealias DataCompletionHandler = ((JSON?, Error?) -> ())

class HTTPAPIService: APIService {
    
    func fetch(for date: Date, completionHandler: @escaping DataCompletionHandler) {
        guard let requestUrl = date.toUrl() else { return }
        let session = URLSession.shared
        let request = URLRequest(url:requestUrl)
        let task = session.dataTask(with: request) { (data, response, error) in
            do {
                let json = try self.convertDataToJsonIntializationObject(data: data,
                                                                         response: response,
                                                                         error: error)
                completionHandler(json, nil)
            } catch {
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
    
    private func convertDataToJsonIntializationObject(data: Data?,
                                                      response: URLResponse?,
                                                      error: Error?) throws -> JSON {
        do {
            guard let jsonObject = try data?.toJSON() else {
                throw NetworkError.invalidJsonObject
            }
            return jsonObject
        } catch {
            throw NetworkError.other
        }
    }
    
}

struct JSONConversionError: Error {}

extension Data {
    func toJSON() throws -> JSON {
        let anyJSON = try JSONSerialization.jsonObject(with: self, options: [])

        guard let json = anyJSON as? JSON else {
            throw JSONConversionError()
        }
        return json
    }
}

