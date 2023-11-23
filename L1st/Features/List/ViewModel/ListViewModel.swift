import Foundation

final class ListViewModel: NSObject {
    private var model = ListModel(entryList: .init(count: .zero, entries: .init()))

    private var filteredEntries: [EntryListDTO.Item] {
        if onFilter {
            let ids = FavoriteEntry.allItems?.map { $0.id } ?? []

            return model.entryList.entries.filter { ids.contains($0.Link.absoluteString) }
        }

        return model.entryList.entries
    }

    @objc dynamic var onFilter = false

    private(set) var onLoad = true

    var entriesCount: Int {
        filteredEntries.count
    }

    subscript(entryIndex: Int) -> EntryListDTO.Item? {
        filteredEntries[safeIndex: entryIndex]
    }

    func isFavoriteEntry(id: String?) -> Bool {
        guard let id = id else {
            return false
        }

        return FavoriteEntry.searchBy(id: id) != nil
    }

    func manageFavoriteEntry(id: String?) -> Bool? {
        guard let id = id else {
            return nil
        }

        if isFavoriteEntry(id: id) {
            FavoriteEntry.removeBy(id: id)

            return false
        }

        FavoriteEntry.insertBy(id: id)

        return true
    }

    func callService() async throws {
        guard let url = URL(string: kApiString) else {
            return
        }

        onLoad = true

        let (data, _) = try await URLSession.shared.data(from: url)

        onLoad = false

        let entryList = try JSONDecoder().decode(
            EntryListDTO.self, from: data
        )

        model = .init(entryList: entryList)
    }
}
