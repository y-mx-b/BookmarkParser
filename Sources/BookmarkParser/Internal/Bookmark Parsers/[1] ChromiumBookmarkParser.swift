import Foundation

struct ChromiumBookmarkParser: BrowserBookmarkParser {
    func getBookmarks(from bookmarksFilePath: URL) -> Data? {
        // TODO change function to a throwing one, make things safer
        do {
            let contents = try Data(contentsOf: bookmarksFilePath)
            return contents
        } catch {
            return nil
        }
    }
    func parseBookmarks(_ bookmarksDump: Data?) -> ChromiumBookmarks? {
        // TODO change function to a throwing one, make things safer
        if bookmarksDump == nil { return nil }

        let decoder = JSONDecoder()
        let data = try! decoder.decode(ChromiumBookmarks.self, from: bookmarksDump!)
        return data
    }

    func returnBookmarks(_ bookmarks: ChromiumBookmarks?) -> OnebookBookmarks? {
        return nil
    }
}
