public protocol OnebookItem {
    associatedtype ItemType: OnebookItem
    var name: String { get }
    var url: String? { get }
    var children: [ItemType]? { get }
}

