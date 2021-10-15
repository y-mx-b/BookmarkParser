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
        if let _ = self.Title {
            return self.Title!
        } else {
            return self.URIDictionary!.title
        }
    }
    public var url: String? { return self.URLString }
    public var children: [ItemType]? { return Children }

    // let WebBookmarkUUID: String
    let Title: String?
    let Children: [ItemType]?
    let URLString: String?
    // let WebBookmarkType: String
    let URIDictionary: SafariURIDictionary?

    public init(name: String, url: String?, children: [ItemType]?) {
        if url != nil {
            self.URLString = url
            self.Title = nil
            self.URIDictionary = SafariURIDictionary(title: name)
        } else {
            self.Title = name
            self.URLString = nil
            self.URIDictionary = nil
        }
        self.Children = children
    }
}
