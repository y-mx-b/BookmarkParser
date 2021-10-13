import Foundation

public struct Roots: Codable {
    let bookmark_bar: ChromiumChildren
    let other: ChromiumChildren
    let synced: ChromiumChildren
}

public struct ChromiumChildren: OnebookItem, Codable {
    typealias ItemType = ChromiumChildren

    let name: String
    let url: String?
    let children: [ItemType]?
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
