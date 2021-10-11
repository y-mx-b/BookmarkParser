import Foundation

public protocol OnebookItem {
    associatedtype ItemType
    var name: String { get }
    var url: String? { get }
    var children: [ItemType]? { get }
}

public struct OnebookChildren: OnebookItem  {
    public let name: String
    public let url: String?
    public let children: [OnebookChildren]?

    public init(name: String, url: String?, children: [OnebookChildren]?) {
        self.name = name
        self.url = url
        self.children = children
    }
}

public struct OnebookBookmarks: Codable {
    public let bookmark_bar: [OnebookChildrenWrapper]?
    public let favorites: [OnebookChildrenWrapper]?
    public let other: [OnebookChildrenWrapper]?
}

public struct OnebookChildrenWrapper: OnebookItem, Codable {
    enum CodingKeys: CodingKey {
        case name
        case url
        case children
    }

    private let _name: () -> String
    private let _url: () -> String?
    private let _children: () -> [OnebookChildrenWrapper]?

    public init(_ item: OnebookChildren) {
        self._name = { return item.name }
        self._url = { return item.url }
        self._children = {
            guard let oldArray = item.children else { return nil }

            var array: [OnebookChildrenWrapper] = [OnebookChildrenWrapper(oldArray[0])]
            for i in 1...oldArray.count-1 {
                array[i] = OnebookChildrenWrapper(oldArray[i])
            }
            return array
        }
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self._name = { try! values.decode(String.self, forKey: .name) }
        self._url = { try! values.decode(String?.self, forKey: .url) }
        self._children = { try! values.decode(Array?.self, forKey: .url) }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(url, forKey: .url)
        try container.encode(children, forKey: .children)
    }

    public var name: String {
        return self._name()
    }

    public var url: String? {
        return self._url()
    }

    public var children: [OnebookChildrenWrapper]? {
        return self._children()
    }
}
