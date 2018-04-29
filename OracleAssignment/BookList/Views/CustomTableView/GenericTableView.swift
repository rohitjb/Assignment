import UIKit

class GenericTableView<Component, Cell: UITableViewCell>: UITableViewController {
    var components: [Component] = []
    let reuseIdentifier = "Cell"
    let configure: (Cell, Component) -> ()

    init(configure: @escaping (Cell, Component) -> ()) {
        self.configure = configure
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        registerCells()
    }

    func updateTableView(with components: [Component]) {
        self.components = components
        tableView.reloadData()
    }
    
    func genericTableView() -> UIView {
        return view
    }
    
    private func registerCells() {
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return components.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Cell(style: .default, reuseIdentifier: "Cell")
        configure(cell, components[indexPath.row])
        return cell
    }
}
