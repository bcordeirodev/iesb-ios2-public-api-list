import UIKit
import SafariServices

final class DetailTableView: UITableViewController {
    @IBOutlet private weak var categoryCell: UITableViewCell!
    @IBOutlet private weak var authCell: UITableViewCell!
    @IBOutlet private weak var corsCell: UITableViewCell!
    @IBOutlet private weak var linkCell: UITableViewCell!

    var viewModel: DetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = viewModel?.title
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            case 0:
                categoryCell.detailTextLabel?.text = viewModel?.category

                return categoryCell

            case 1:
                authCell.detailTextLabel?.text = viewModel?.auth

                return authCell

            case 2:
                corsCell.detailTextLabel?.text = viewModel?.cors

                return corsCell

            case 3:
                linkCell.textLabel?.textColor = (viewModel?.isSecure ?? false) ? .systemGreen : .systemRed

                return linkCell

            default:
                return .init()
        }
    }

    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if let url = viewModel?.url, indexPath.row == 3 {
            present(SFSafariViewController(url: url), animated: true)
        }
    }
}
