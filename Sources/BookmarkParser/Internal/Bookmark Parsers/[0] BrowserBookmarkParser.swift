import Foundation

protocol BrowserBookmarkParser {
    associatedtype BookmarkType

    // var browser: [Browser] { get }
    // var format: FormatTypes { get }

    func getBookmarks(from bookmarksFilePath: String, browser: Browser) throws -> Data
    func parseBookmarks(_ bookmarksDump: Data, from browser: Browser) throws -> BookmarkType
    func returnBookmarks(_ bookmarks: BookmarkType) -> [OnebookChildren]?
    func convertBookmarks(_ bookmarkData: Data, to format: FormatTypes) throws -> BookmarkType?
}

struct AnyBrowserBookmarkParser<BookmarkType: OnebookItem>: BrowserBookmarkParser {
    private let _getBookmarks: (String, Browser) throws -> Data
    private let _parseBookmarks: (Data, Browser) throws -> BookmarkType
    private let _returnBookmarks: (BookmarkType) -> [OnebookChildren]?
    private let _convertBookmarks: (Data, FormatTypes) throws -> BookmarkType?

    init<Parser: BrowserBookmarkParser>(_ parser: Parser) where Parser.BookmarkType == BookmarkType {
        self._getBookmarks = parser.getBookmarks
        self._parseBookmarks = parser.parseBookmarks
        self._returnBookmarks = parser.returnBookmarks
        self._convertBookmarks = parser.convertBookmarks
    }

    public func getBookmarks(from bookmarksFilePath: String, browser: Browser) throws -> Data {
        try self._getBookmarks(bookmarksFilePath, browser)
    }

    public func parseBookmarks(_ bookmarksDump: Data, from browser: Browser) throws -> BookmarkType {
        try self._parseBookmarks(bookmarksDump, browser)
    }

    public func returnBookmarks(_ bookmarks: BookmarkType) -> [OnebookChildren]? {
        self._returnBookmarks(bookmarks)
    }

    public func convertBookmarks(_ bookmarkData: Data, to format: FormatTypes) throws -> BookmarkType? {
        try self._convertBookmarks(bookmarkData, format)
    }
}

