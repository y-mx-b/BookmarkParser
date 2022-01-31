import Foundation

public struct SafariURIDictionary: Codable {
    let title: String

    public init(title: String) {
        self.title = title
    }
}

public struct SafariChildren: OnebookItem, Codable {
    public typealias ItemType = SafariChildren

    public var name: String {
        if let _ = Title {
            return Title!
        } else {
            return URIDictionary!.title
        }
    }

    public var url: String? { URLString }
    public var children: [ItemType]? { Children }

    // let WebBookmarkUUID: String
    let Title: String?
    let Children: [ItemType]?
    let URLString: String?
    // let WebBookmarkType: String
    let URIDictionary: SafariURIDictionary?

    public init(name: String, url: String?, children: [ItemType]?) {
        if url != nil {
            URLString = url
            Title = nil
            URIDictionary = SafariURIDictionary(title: name)
        } else {
            Title = name
            URLString = nil
            URIDictionary = nil
        }
        Children = children
    }
}
