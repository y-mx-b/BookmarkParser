import Foundation

public struct Roots: Codable {
    public let bookmark_bar: ChromiumChildren
    public let other: ChromiumChildren
    public let synced: ChromiumChildren

    public init(bookmark_bar: ChromiumChildren, other: ChromiumChildren, synced: ChromiumChildren) {
        self.bookmark_bar = bookmark_bar
        self.other = other
        self.synced = synced
    }
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
    public let roots: Roots
    // let version: Int
    public init(roots: Roots) {
        self.roots = roots
    }
}
