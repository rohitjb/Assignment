import Foundation

struct ErrorViewState {
    var errorMessage: String
    let error: Error
    
    init(error: Error) {
        self.error = error
        self.errorMessage = "There is some internal error or connection unavailable. Please try after some time."
    }
}
