import Foundation

struct SafariBookmarkParser: BrowserBookmarkParser {
    func getBookmarks(from bookmarksFilePath: URL) -> Data? {
        // TODO change fuction to throw, make safer
        do {
            let contents = try Data(contentsOf: bookmarksFilePath)
            return contents
        } catch {
            print(error)
            return nil
        }
    }
    func parseBookmarks(_ bookmarksDump: Data?) -> SafariChildren? {
        // TODO change function to throw, make safer
        if bookmarksDump == nil { return nil }
        let plistData = bookmarksDump
        let decoder = PropertyListDecoder()
        let data = try! decoder.decode(SafariChildren.self, from: plistData!)
        return data
    }
}
