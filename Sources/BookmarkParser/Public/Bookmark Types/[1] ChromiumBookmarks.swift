import Foundation

public struct Roots: Codable {
    let bookmark_bar: ChromiumChildren
    let other: ChromiumChildren
    let synced: ChromiumChildren
}

public struct ChromiumChildren: OnebookItem, Codable {
    public let name: String
    public let url: String?
    public let children: [ChromiumChildren]?
    // let date_added: String
    // let guid: String
    // let id: String
    // let type: String
}

public struct ChromiumBookmarks: Codable {
    // let checksum: String
    let roots: Roots
    // let version: Int
}
