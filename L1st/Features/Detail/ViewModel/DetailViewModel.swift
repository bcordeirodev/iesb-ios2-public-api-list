import Foundation

final class DetailViewModel: NSObject {
    private let model: DetailModel

    var title: String {
        model.entry.API
    }

    var category: String {
        model.entry.Category
    }

    var auth: String {
        if model.entry.Auth.isEmpty {
            return "none"
        }

        return model.entry.Auth
    }

    var cors: String {
        model.entry.Cors
    }

    var isSecure: Bool {
        model.entry.HTTPS
    }

    var url: URL {
        model.entry.Link
    }

    init(model: DetailModel) {
        self.model = model
    }
}
