import XCTest
@testable import L1st

final class L1stTests: XCTestCase {
    let sut = ListViewModel()

    func test_subscript_empty() throws {
        //GIVEN
        var entry: EntryListDTO.Item?

        //WHEN
        entry = sut[0]

        //THEN
        XCTAssertNil(entry)
    }

    func test_favorite_none_flow_nil() throws {
        //GIVEN
        var isNoneFlow: Bool?

        //WHEN
        isNoneFlow = sut.manageFavoriteEntry(id: nil)

        //THEN
        XCTAssertNil(isNoneFlow)
    }

    func test_favorite_remove_flow_empty() throws {
        //GIVEN
        var isAnyFlow: Bool?

        //WHEN
        isAnyFlow = sut.manageFavoriteEntry(id: .init())

        //THEN
        XCTAssertNotNil(isAnyFlow)
    }

    func test_favorite_insert_flow_empty() throws {
        //GIVEN
        var isAnyFlow: Bool?

        //WHEN
        isAnyFlow = sut.manageFavoriteEntry(id: .init())

        //THEN
        XCTAssertNotNil(isAnyFlow)
    }

    func test_on_filter_count() throws {
        //GIVEN
        var count = 0

        //WHEN
        sut.onFilter = true

        count = sut.entriesCount

        //THEN
        XCTAssertEqual(count, 0)
    }

    func test_not_favorite_entry() throws {
        //GIVEN
        var isFavorite: Bool = true

        //WHEN
        isFavorite = sut.isFavoriteEntry(id: nil)

        //THEN
        XCTAssertFalse(isFavorite)
    }

    func test_nil_favorite_entry() throws {
        //GIVEN
        var isFavorite: Bool = true

        //WHEN
        isFavorite = sut.isFavoriteEntry(id: nil)

        //THEN
        XCTAssertFalse(isFavorite)
    }

    func test_none_favorite_entry() throws {
        //GIVEN
        var isFavorite: Bool = true

        //WHEN
        isFavorite = sut.isFavoriteEntry(id: " ")

        //THEN
        XCTAssertFalse(isFavorite)
    }
}
