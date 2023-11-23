import Foundation

let kApiString = "https://api.publicapis.org/entries"

struct EntryListDTO: Decodable {
    // Keep Capitalized for Less Code
    struct Item: Decodable {
        let API: String
        let Description: String
        let Auth: String
        let HTTPS: Bool
        let Cors: String
        let Link: URL
        let Category: String
    }

    let count: Int
    let entries: [Item]
}
