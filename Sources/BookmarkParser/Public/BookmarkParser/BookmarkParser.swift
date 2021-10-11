import Foundation

public enum BookmarkParserError: Error {
    // PARSING
    case noBookmarkFile(String)
    case emptyBookmarksFile(String)
    case improperBookmarkData
    // CONVERSION
    case invalidBrowser(Browser)
    case invalidFormatType(FormatTypes)
}

public struct BookmarkParser {
    public var browser: Browser
    public var bookmarksFilePath: String? { BookmarkPaths[browser] }

    public func getBookmarks(from bookmarksFilePath: String, browser: Browser) throws -> Data {
        switch browser {
        // CHROMIUM
        case .chromium, .chrome, .brave, .edge:
            return try ChromiumBookmarkParser().getBookmarks(from: bookmarksFilePath, browser: browser)
        // SAFARI
        case .safari:
            return try SafariBookmarkParser().getBookmarks(from: bookmarksFilePath)
        // TODO add other browsers
        default:
            return try ChromiumBookmarkParser().getBookmarks(from: bookmarksFilePath, browser: browser)
        }
    }

    public func parseBookmarks(_ bookmarksDump: Data, from browser: Browser) throws -> OnebookBookmarks {
        switch browser {
        // CHROMIUM
        case .chromium, .chrome, .brave, .edge:
            let bookmarks = try ChromiumBookmarkParser().parseBookmarks(bookmarksDump, from: browser)
            return ChromiumBookmarkParser().returnBookmarks(bookmarks)!
        // SAFARI
        case .safari:
            let bookmarks = try SafariBookmarkParser().parseBookmarks(bookmarksDump)
            return SafariBookmarkParser().returnBookmarks(bookmarks)!
        // TODO add other browsers
        default:
            let bookmarks = try ChromiumBookmarkParser().parseBookmarks(bookmarksDump, from: browser)
            return ChromiumBookmarkParser().returnBookmarks(bookmarks)!
        }
    }

    public func convertBookmarks(_ bookmarks: OnebookBookmarks, to format: FormatTypes) throws -> Any? {
        switch format {
        // case .html:
        case .json:
            return try ChromiumBookmarkParser().convertBookmarks(bookmarks, to: format)
        case .plist:
            return try SafariBookmarkParser().convertBookmarks(bookmarks, to: format)
        // case .sqlite:
        case .onebook:
            throw BookmarkParserError.invalidFormatType(format)
        default:
            throw BookmarkParserError.invalidFormatType(format)
        }
    }
}

