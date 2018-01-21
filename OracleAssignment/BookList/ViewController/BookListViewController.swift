import UIKit

class BookListViewController: UIViewController, BookListViewControllerDelegate {
    private let presenter: BookListPresenter
    private let bookListView = BookListView()
    
    init(navigator: BookListNavigator) {
        let useCase = DefaultBookListUseCase(dataSource: DefaultBookListDataSource())
        self.presenter = BookListPresenter(displayer: bookListView, useCase: useCase, navigator: navigator)

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "BookList"
        setup()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: Date().toDateString(), style: .plain, target: self, action: #selector(dateSelectionButtonPressed))
        presenter.startPresenting()
    }
    
    @objc func dateSelectionButtonPressed() {
        bookListView.showDateSelectionView()
    }
    
    private func setup() {
        view = UIView()
        view.addSubview(bookListView)
        bookListView.delegate = self
        bookListView.pinToSuperviewEdges()
        view.backgroundColor = .white
    }
    
    func didChangeDate(date: Date) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: date.toDateString(), style: .plain, target: self, action: #selector(dateSelectionButtonPressed))
    }
}

