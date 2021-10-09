import Foundation

struct ChromiumBookmarkParser: BrowserBookmarkParser {
    func getBookmarks(from bookmarksFilePath: String) throws -> Data {
        let fm = FileManager.default
        guard fm.fileExists(atPath: bookmarksFilePath)
            else { throw BrowserBookmarkParserError.noBookmarkFile(bookmarksFilePath) }
        guard let contents = fm.contents(atPath: bookmarksFilePath)
            else { throw BrowserBookmarkParserError.emptyBookmarksFile(bookmarksFilePath) }
        return contents
    }

    func parseBookmarks(_ bookmarksDump: Data) throws -> ChromiumBookmarks {
        guard let bookmarks = try? JSONDecoder().decode(ChromiumBookmarks.self, from: bookmarksDump)
            else { throw BrowserBookmarkParserError.improperBookmarkData }
        return bookmarks
    }

    func returnBookmarks(_ bookmarks: ChromiumBookmarks) -> OnebookBookmarks? {
        // TODO implement this
        return nil
    }
}
