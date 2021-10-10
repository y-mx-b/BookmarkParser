import Foundation

public enum BrowserBookmarkParserError: Error {
    case noBookmarkFile(String)
    case emptyBookmarksFile(String)
    case improperBookmarkData
}

public struct BookmarkParser {
    public var browser: Browser
    public var bookmarksFilePath: String? { BookmarkPaths[browser] }

    public func getBookmarks(from bookmarksFilePath: String) throws -> Data {
        switch browser {
        // CHROMIUM
        case .chromium, .chrome, .brave, .edge:
            return try ChromiumBookmarkParser().getBookmarks(from: bookmarksFilePath)
        // SAFARI
        case .safari:
            return try SafariBookmarkParser().getBookmarks(from: bookmarksFilePath)
        // TODO add other browsers
        default:
            return try ChromiumBookmarkParser().getBookmarks(from: bookmarksFilePath)
        }
    }

    public func parseBookmarks(_ bookmarksDump: Data) throws -> OnebookBookmarks {
        switch browser {
        // CHROMIUM
        case .chromium, .chrome, .brave, .edge:
            let bookmarks = try ChromiumBookmarkParser().parseBookmarks(bookmarksDump)
            return ChromiumBookmarkParser().returnBookmarks(bookmarks)!
        // SAFARI
        case .safari:
            let bookmarks = try SafariBookmarkParser().parseBookmarks(bookmarksDump)
            return SafariBookmarkParser().returnBookmarks(bookmarks)!
        // TODO add other browsers
        default:
            let bookmarks = try ChromiumBookmarkParser().parseBookmarks(bookmarksDump)
            return ChromiumBookmarkParser().returnBookmarks(bookmarks)!
        }
    }

    public func convert<T: Codable>(_ bookmarks: OnebookBookmarks) throws -> T? {
        return nil
    }

}

