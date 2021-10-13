import Foundation

public struct Roots: Codable {
    let bookmark_bar: ChromiumChildren
    let other: ChromiumChildren
    let synced: ChromiumChildren
}

public struct ChromiumChildren: OnebookItem, Codable {
    public typealias ItemType = ChromiumChildren

    public let name: String
    public let url: String?
    public let children: [ItemType]?
    // let date_added: String
    // let guid: String
    // let id: String
    // let type: String

    public init(name: String, url: String?, children: [ItemType]?) {
        self.name = name
        self.url = url
        self.children = children
    }
}

public struct ChromiumBookmarks: Codable {
    // let checksum: String
    let roots: Roots
    // let version: Int
}
