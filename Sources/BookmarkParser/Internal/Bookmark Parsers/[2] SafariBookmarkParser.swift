import Foundation

struct SafariBookmarkParser: BrowserBookmarkParser {
    func getBookmarks(from bookmarksFilePath: String) throws -> Data {
        let fm = FileManager.default
        guard fm.fileExists(atPath: bookmarksFilePath)
            else { throw BrowserBookmarkParserError.noBookmarkFile(bookmarksFilePath) }
        guard let contents = fm.contents(atPath: bookmarksFilePath)
            else { throw BrowserBookmarkParserError.emptyBookmarksFile(bookmarksFilePath) }
        return contents
    }

    func parseBookmarks(_ bookmarksDump: Data) throws -> SafariChildren {
        guard let bookmarks = try? PropertyListDecoder().decode(SafariChildren.self, from: bookmarksDump)
            else { throw BrowserBookmarkParserError.improperBookmarkData }
        return bookmarks
    }

    func returnBookmarks(_ bookmarks: SafariChildren) -> OnebookBookmarks? {
        // TODO implement this
        return nil
    }
}
