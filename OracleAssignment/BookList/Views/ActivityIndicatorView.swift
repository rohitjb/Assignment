import Foundation
import UIKit

class ActivityIndicatorView: UIView {
    
    private let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This view is not designed to be used with xib or storyboard files")
    }
    
    private func setup() {
        backgroundColor = .clear
        addSubview(spinner)
        spinner.color = UIColor.gray
        
        spinner.pinCenterX(to: self)
        spinner.pinCenterY(to: self)
        isUserInteractionEnabled = false
    }
    
    func startActivityIndicator() {
        startAnimating()
        
    }
    
    private func startAnimating() {
        spinner.startAnimating()
    }
    
    func stopAnimating() {
        spinner.stopAnimating()
    }
}

