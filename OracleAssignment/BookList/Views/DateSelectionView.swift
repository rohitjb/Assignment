import UIKit

protocol DateSelectionViewDelegate: class {
    func didSelectDate(date: Date)
}

class DateSelectionView: UIView {
    
    private let datePicker: UIDatePicker = UIDatePicker()
    private let toolBar: UIToolbar = UIToolbar()
    weak var delegate: DateSelectionViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        backgroundColor = UIColor.white
        toolBar.barTintColor = UIColor.orange
        toolBar.tintColor = UIColor.white
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonPressed))
        toolBar.items = [barButton]
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.maximumDate = Date()
        addSubview(datePicker)
        addSubview(toolBar)
        applyConstraints()
    }
    
    @objc func doneButtonPressed() {
        delegate?.didSelectDate(date: datePicker.date)
    }

    private func applyConstraints() {
        toolBar.pinToSuperview(edges: [.top , .leading, .trailing])
        datePicker.pin(edge: .top, to: .bottom, of: toolBar)
        datePicker.pinToSuperview(edges: [.bottom, .leading, .trailing])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
