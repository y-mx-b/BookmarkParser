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

    public init(browser: Browser) {
        self.browser = browser
    }

    public func getBookmarkData(from bookmarksFilePath: String, browser: Browser) throws -> Data {
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

    public func parseBookmarkData(_ bookmarksDump: Data, from browser: Browser) throws -> [OnebookChildren]? {
        switch browser {
        // CHROMIUM
        case .chromium, .chrome, .brave, .edge:
            let parser = ChromiumBookmarkParser()
            let bookmarks = try parser.parseBookmarks(bookmarksDump, from: browser)
            return parser.returnBookmarks(bookmarks)!
        // SAFARI
        case .safari:
            let parser = SafariBookmarkParser()
            let bookmarks = try parser.parseBookmarks(bookmarksDump)
            return parser.returnBookmarks(bookmarks)!
        // TODO add other browsers
        default:
            throw BookmarkParserError.emptyBookmarksFile("sike")
        }
    }

    public func convertBookmarks<BookmarkType>(_ bookmarks: [OnebookChildren],
                                               to format: FormatTypes) throws -> [AnyOnebookItem<BookmarkType>] {
        switch format {
        // case .html:
        //     throw BookmarkParserError.invalidFormatType(format)
        // case .json:
        //     return
        // case .plist:
        //     return try SafariBookmarkParser().convertBookmarks(bookmarks, to: format)
        // case .sqlite:
        //     throw BookmarkParserError.invalidFormatType(format)
        // case .onebook:
        //     throw BookmarkParserError.invalidFormatType(format)
        default:
            throw BookmarkParserError.invalidFormatType(format)
        }
    }
}

