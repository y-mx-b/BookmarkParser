import Foundation

protocol BrowserBookmarkParser {
    associatedtype BookmarkType

    var browser: [Browser] { get }
    var format: FormatTypes { get }

    func getBookmarks(from bookmarksFilePath: String, browser: Browser) throws -> Data
    func parseBookmarks(_ bookmarksDump: Data, from browser: Browser) throws -> BookmarkType
    func returnBookmarks(_ bookmarks: BookmarkType) -> [OnebookChildren]?
    func convertBookmarks(_ bookmarkData: Data, to format: FormatTypes) throws -> BookmarkType?
}

