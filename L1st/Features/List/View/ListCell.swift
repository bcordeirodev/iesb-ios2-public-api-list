import UIKit

final class ListCell: UITableViewCell {
    @IBOutlet private weak var apiNameLabel: UILabel!
    @IBOutlet private weak var apiTextLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!

    @IBAction private func favoriteAction() {
        favoriteCompletion?(id)
    }

    private var id: String?

    func setDatas(name: String, text: String, id: String?) {
        apiNameLabel.text = name
        apiTextLabel.text = text

        self.id = id
    }

    func setFavorite(isFilled: Bool) {
        let systemName = isFilled ? "star.fill" : "star"

        favoriteButton.setImage(
            .init(systemName: systemName), for: .normal
        )
    }

    var favoriteCompletion: ((String?) -> Void)?
}
