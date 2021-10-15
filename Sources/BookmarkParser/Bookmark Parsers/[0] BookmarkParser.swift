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

public enum BookmarkConversionError: Error {
    case invalidFormatType(FormatTypes)
}

public protocol BookmarkParser {
    associatedtype BookmarkType

    func getBookmarkData(from bookmarksFilePath: String) throws -> Data
    func parse(_ bookmarksDump: Data) throws -> BookmarkType
    func convert<ItemType: OnebookItem>(_ bookmark: ItemType) throws -> BookmarkType
    func convert<ItemType: OnebookItem>(_ bookmark: [ItemType]) throws -> [BookmarkType]
}


// GLOBAL INTERNAL FUNCTION
func getBookmarkContents(from bookmarksFilePath: String) throws -> Data {
    let fm = FileManager.default

    guard fm.fileExists(atPath: bookmarksFilePath) else {
        throw BookmarkParserError.noBookmarkFile(bookmarksFilePath)
    }
    guard let contents = fm.contents(atPath: bookmarksFilePath) else {
        throw BookmarkParserError.emptyBookmarksFile(bookmarksFilePath)
    }

    return contents
}
