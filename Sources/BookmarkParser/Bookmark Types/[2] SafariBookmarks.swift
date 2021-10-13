import Foundation

public struct SafariURIDictionary: Codable {
    let title: String
}

public struct SafariChildren: OnebookItem, Codable {
    typealias ItemType = SafariChildren

    var name: String {
        if let _ = self.Title {
            return self.Title!
        } else {
            return self.URIDictionary!.title
        }
    }
    var url: String? { return self.URLString }
    var children: [ItemType]? { return Children }

    // let WebBookmarkUUID: String
    let Title: String?
    let Children: [SafariChildren]?
    let URLString: String?
    // let WebBookmarkType: String
    let URIDictionary: SafariURIDictionary?
}
