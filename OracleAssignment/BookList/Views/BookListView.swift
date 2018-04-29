import UIKit

protocol BookListViewControllerDelegate: class {
    func didChangeDate(date: Date)
}

class BookListView: UIView, BookListDisplayer, DateSelectionViewDelegate {
    
    private let bookList = GenericTableView<Book, BookTableViewCell> { (cell, book) in
        cell.upateWithBook(book: book)
    }
    
    lazy var bookListView: UIView = {
        return bookList.genericTableView()
    }()

    private let searchView = UISearchBar()
    private let activityIndicator = ActivityIndicatorView()
    private let searchViewAdapter = SearchAdapter()
    private var actionListener: BookListActionListener?
    private let errorView: ErrorView = ErrorView()
    private var dateSelectionView =  DateSelectionView()
    private var bottomConstraints: NSLayoutConstraint?
    weak var delegate: BookListViewControllerDelegate?
    private var reloadWithDate: ((Date) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(bookListView)
        addSubview(searchView)
        addSubview(activityIndicator)
        addSubview(errorView)
        
        addSubview(dateSelectionView)
        dateSelectionView.delegate = self
        
        searchView.placeholder = "Search"
        searchView.delegate = searchViewAdapter
        applyConstraints()
        activityIndicator.isHidden = true
        dateSelectionView.isHidden = true
}
    
    private func applyConstraints() {
        searchView.pinToSuperview(edges: [.top, .leading, .trailing])
        bookListView.pin(edge: .top, to: .bottom, of: searchView)
        bookListView.pinToSuperview(edges: [.bottom, .leading, .trailing])

        activityIndicator.pinToSuperviewEdges()
        errorView.pinToSuperviewEdges()
        dateSelectionView.pinToSuperview(edges: [.leading, .trailing])
        bottomConstraints = dateSelectionView.pinBottom(to: self, constant: 260)
    }
    
    func showDateSelectionView() {
        UIView.animate(withDuration: 0.7) {[weak self] in
            self?.dateSelectionView.isHidden = false
            self?.bottomConstraints?.constant = 0
            self?.layoutIfNeeded()
        }
    }
    
    private func hideDateSelectionView() {
        UIView.animate(withDuration: 0.7) {[weak self] in
            self?.bottomConstraints?.constant = 260
            self?.layoutIfNeeded()
            self?.dateSelectionView.isHidden = true
        }
    }

    func setLoading() {
        activityIndicator.isHidden = false
        activityIndicator.startActivityIndicator()
    }
    
    func update(with books: [Book]) {
        activityIndicator.isHidden = true
        bookListView.isHidden = false
        errorView.isHidden = true
        bookList.updateTableView(with: books)
    }
    
    func update(with errorViewState: ErrorViewState) {
        activityIndicator.isHidden = true
        bookListView.isHidden = true
        errorView.isHidden = false
        errorView.updateViewWithError(error: errorViewState)
    }
    
    func attachListener(listener: BookListActionListener) {
        actionListener = listener
        reloadWithDate = listener.reloadWithDate
        searchViewAdapter.attachListener(listener: listener)
    }
    
    func didSelectDate(date: Date) {
        delegate?.didChangeDate(date: date)
        hideDateSelectionView()
        reloadWithDate?(date)
    }
    
    func detachListener() {
        actionListener = nil
    }
}
