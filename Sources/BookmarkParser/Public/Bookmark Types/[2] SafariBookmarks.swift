import Foundation

public struct SafariURIDictionary: Codable {
    let title: String
}

public struct SafariChildren: OnebookItem, Codable {
    public var name: String {
        if let _ = self.Title {
            return self.Title!
        } else {
            return self.URIDictionary!.title
        }
    }
    public var url: String? { return self.URLString }
    public var children: [SafariChildren]? { return Children }

    // let WebBookmarkUUID: String
    let Title: String?
    let Children: [SafariChildren]?
    let URLString: String?
    // let WebBookmarkType: String
    let URIDictionary: SafariURIDictionary?
}
