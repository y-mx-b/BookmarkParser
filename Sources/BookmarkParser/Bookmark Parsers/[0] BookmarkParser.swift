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

public protocol BookmarkParser {
    associatedtype BookmarkType

    func getBookmarkData(from bookmarksFilePath: String, format: FormatTypes) throws -> Data
    func parse(_ bookmarksDump: Data, format: FormatTypes) throws -> BookmarkType
}
