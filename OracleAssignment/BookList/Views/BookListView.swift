import UIKit

protocol BookListViewControllerDelegate: class {
    func didChangeDate(date: Date)
}

class BookListView: UIView, BookListDisplayer, DateSelectionViewDelegate {
    private let bookList: UITableView = UITableView()
    private let searchView = UISearchBar()
    private let activityIndicator = ActivityIndicatorView()
    private let searchViewAdapter = SearchAdapter()
    private let bookListAdapter = BookListAdapter()
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
        addSubview(bookList)
        addSubview(searchView)
        addSubview(activityIndicator)
        addSubview(errorView)
        addSubview(dateSelectionView)
        dateSelectionView.delegate = self
        configureTableView()
        searchView.placeholder = "Search"
        searchView.delegate = searchViewAdapter
        applyConstraints()
        activityIndicator.isHidden = true
        dateSelectionView.isHidden = true
}
        
    private func configureTableView() {
        bookList.tableFooterView = UIView(frame: CGRect.zero)
        bookList.dataSource = bookListAdapter
        bookList.delegate = bookListAdapter
        bookList.estimatedRowHeight = 200
        bookList.rowHeight = UITableViewAutomaticDimension
        registerCells()
    }
    
    private func registerCells() {
        bookList.register(BookTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    private func applyConstraints() {
        searchView.pinToSuperview(edges: [.top, .leading, .trailing])
        bookList.pin(edge: .top, to: .bottom, of: searchView)
        bookList.pinToSuperview(edges: [.bottom, .leading, .trailing])
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
        bookList.isHidden = false
        errorView.isHidden = true
        bookListAdapter.updateViewState(with: books)
        bookList.reloadData()
    }
    
    func update(with errorViewState: ErrorViewState) {
        activityIndicator.isHidden = true
        bookList.isHidden = true
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
