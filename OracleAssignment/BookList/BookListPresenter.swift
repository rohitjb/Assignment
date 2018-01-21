import Foundation

protocol BookListDisplayer {
    func setLoading()
    func update(with books: [Book])
    func update(with error: ErrorViewState)
    func attachListener(listener: BookListActionListener)
    func detachListener()
}

struct BookListActionListener {
    let search: (String) -> Void
    let reloadWithDefaultValue: () -> ()
    let reloadWithDate: (Date) -> ()
}

class BookListPresenter {
    private let navigator: BookListNavigator
    private let useCase: BookListUseCase
    private let displayer: BookListDisplayer
    private var books: [Book]?
    
    init(displayer: BookListDisplayer, useCase: BookListUseCase, navigator: BookListNavigator) {
        self.displayer = displayer
        self.navigator = navigator
        self.useCase = useCase
    }
    
    func startPresenting() {
        displayer.attachListener(listener: newListener())
        self.loadData(date: Date())
    }
    
    private func loadData(date: Date) {
        displayer.setLoading()
        useCase.loadBookList(date: date, completionHandler: update)
    }
    
    func update(books: [Book]?, error: Error?) {
        DispatchQueue.main.async {[weak self] in
            self?.handleErrorIfAny(error: error)
            guard let books = books else { return }
            self?.books  = books
            self?.displayer.update(with: books)
        }
    }
    
    private func handleErrorIfAny(error: Error?)  {
        guard let error = error else { return }
        DispatchQueue.main.async {
            self.displayer.update(with: ErrorViewState(error: error))
        }
    }
    
    func newListener() -> BookListActionListener {
        return BookListActionListener(search: { [weak self] text in
            if !text.isEmpty {
                if let filteredArray = self?.books?.filter({ $0.title.lowercased().contains(text.lowercased()) || $0.publisher.lowercased().contains(text.lowercased())}) {
                    self?.displayer.update(with: filteredArray)
                }
            }
         }, reloadWithDefaultValue: { [weak self] in
                self?.displayer.update(with: self?.books ?? [])
            }, reloadWithDate: { [weak self] date in
                self?.loadData(date: date)
        })
    }
}
