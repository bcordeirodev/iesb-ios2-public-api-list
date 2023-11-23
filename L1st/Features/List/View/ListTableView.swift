import UIKit

final class ListTableView: UITableViewController {
    @IBOutlet private weak var favoriteButton: UIBarButtonItem!
    @IBOutlet private weak var errorView: ListErrorView!

    @IBOutlet private var viewModel: ListViewModel! = .init()

    private var onFilterObserver: NSKeyValueObservation?

    @IBAction func loadAction(_ sender: UIRefreshControl?) {
        Task {
            try await viewModel.callService()

            sender?.endRefreshing()

            configureBackground()
        }
    }
    
    @IBAction private func filterAction(_ sender: UIBarButtonItem) {
        viewModel.onFilter = favoriteButton.tag == 1
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        onFilterObserver = observe(\.viewModel.onFilter, options: [.initial, .new]) { object, _ in
            if object.viewModel.onFilter {
                object.favoriteButton.title = "All Entries"
                object.favoriteButton.tag = 0
            } else {
                object.favoriteButton.title = "Favorites"
                object.favoriteButton.tag = 1
            }

            object.tableView.bounces = object.viewModel.onFilter == false

            Task {
                object.configureBackground()
            }
        }

        loadAction(tableView.refreshControl)
    }

    private func configureBackground() {
        if viewModel.entriesCount == .zero {
            let string =
                if viewModel.onLoad {
                    "Waiting..."
                } else {
                    if viewModel.onFilter {
                        "No favorites"
                    } else {
                        "No entries"
                    }
                }

            errorView.setText(string: string)

            tableView.backgroundView = errorView
        } else {
            tableView.backgroundView = nil
        }

        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.entriesCount != .zero ? "Entries Count: \(viewModel.entriesCount)" : nil
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.entriesCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let entry = viewModel[indexPath.row] else {
            return .init()
        }

        let abstractCell = tableView.dequeueReusableCell(
            withIdentifier: "CustomCell", for: indexPath
        )

        guard let cell = abstractCell as? ListCell else {
            return .init()
        }

        let id = entry.Link.absoluteString

        cell.setDatas(name: entry.API, text: entry.Description, id: id)
        cell.setFavorite(isFilled: viewModel.isFavoriteEntry(id: id))

        cell.favoriteCompletion = { [weak self] id in
            let isFilled = self?.viewModel.manageFavoriteEntry(id: id)
            let onFilter = self?.viewModel.onFilter

            guard 
                let isFilled = isFilled,
                let onFilter = onFilter
            else {
                return
            }

            cell.setFavorite(isFilled: isFilled)

            if onFilter {
                self?.configureBackground()
            }
        }

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard 
            let indexPath = tableView.indexPathForSelectedRow,
            let entry = viewModel[indexPath.row]
        else {
            return
        }

        if let viewController = segue.destination as? DetailTableView {
            viewController.viewModel = .init(model: .init(entry: entry))
        }
    }
}
