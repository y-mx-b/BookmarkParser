import Foundation

public enum BrowserBookmarkParserError: Error {
    case noBookmarkFile(String)
    case emptyBookmarksFile(String)
    case improperBookmarkData
}

public struct BookmarkParser<T: Codable>: BrowserBookmarkParser {
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

    public func parseBookmarks(_ bookmarksDump: Data) throws -> T {
        switch browser {
        // CHROMIUM
        case .chromium, .chrome, .brave, .edge:
            return try ChromiumBookmarkParser().parseBookmarks(bookmarksDump) as! T
        // SAFARI
        case .safari:
            return try SafariBookmarkParser().parseBookmarks(bookmarksDump) as! T
        // TODO add other browsers
        default:
            return try ChromiumBookmarkParser().parseBookmarks(bookmarksDump) as! T
        }
    }

    public func returnBookmarks(_ bookmarks: T) -> OnebookBookmarks? {
        return nil
    }
}

