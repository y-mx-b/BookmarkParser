import Foundation

public protocol OnebookItem {
    associatedtype ItemType: OnebookItem
    var name: String { get }
    var url: String? { get }
    var children: [ItemType]? { get }
}

public struct OnebookChildren: OnebookItem, Codable {
    public typealias ItemType = OnebookChildren

    public var name: String
    public var url: String?
    public var children: [ItemType]?

    public init(name: String, url: String?, children: [ItemType]?) {
        self.name = name
        self.url = url
        self.children = children
    }
}
