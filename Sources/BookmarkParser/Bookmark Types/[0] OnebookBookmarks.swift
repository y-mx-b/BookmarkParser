import Foundation

protocol OnebookItem {
    associatedtype ItemType: OnebookItem
    var name: String { get }
    var url: String? { get }
    var children: [ItemType]? { get }
}

public struct OnebookChildren: OnebookItem, Codable {
    public var name: String
    public var url: String?
    public var children: [OnebookChildren]?

    public init(name: String, url: String?, children: [OnebookChildren]?) {
        self.name = name
        self.url = url
        self.children = children
    }
}
