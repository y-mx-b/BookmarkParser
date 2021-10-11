import Foundation

public protocol OnebookItem {
    associatedtype ItemType
    var name: String { get }
    var url: String? { get }
    var children: [ItemType]? { get }
}

public struct OnebookChildren: OnebookItem, Codable {
    public let name: String
    public let url: String?
    public let children: [OnebookChildren]?
}

public struct OnebookBookmarks: Codable {
    public let children: [OnebookChildren]?
}
