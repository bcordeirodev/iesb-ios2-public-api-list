import UIKit

final class ListErrorView: UIView {
    @IBOutlet private weak var warningLabel: UILabel!

    func setText(string: String) {
        warningLabel.text = string
    }
}
