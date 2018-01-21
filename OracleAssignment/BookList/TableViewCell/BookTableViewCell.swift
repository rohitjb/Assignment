import UIKit

class BookTableViewCell: UITableViewCell {
    private let bookTitleLabel = UILabel()
    private let bookDescriptionLabel = UILabel()
    private let bookPublisherLabel = UILabel()

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(bookTitleLabel)
        addSubview(bookDescriptionLabel)
        addSubview(bookPublisherLabel)
        bookDescriptionLabel.numberOfLines = 0
        bookTitleLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        bookPublisherLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        applyConstraints()
    }
    
    func upateWithBook(book: Book) {
        bookTitleLabel.text = book.title
        bookDescriptionLabel.text = book.description
        bookPublisherLabel.text = book.publisher
    }
    
    private func applyConstraints() {
        bookTitleLabel.pinToSuperview(edges: [.top], constant: 8)
        bookTitleLabel.pinToSuperview(edges: [.leading, .trailing], constant: 8)
        
        bookPublisherLabel.pin(edge: .top, to: .bottom, of: bookTitleLabel, constant: 8)
        bookPublisherLabel.pinToSuperview(edges: [.leading, .trailing], constant: 8)

        bookDescriptionLabel.pin(edge: .top, to: .bottom, of: bookPublisherLabel, constant: 8)
        bookDescriptionLabel.pinToSuperview(edges: [.leading, .trailing], constant: 8)
        bookDescriptionLabel.pinToSuperview(edges: [.bottom], constant: 8)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
