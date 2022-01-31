import Foundation

public enum BookmarkParserError: Error {
    // PARSING
    case noBookmarkFile(String) // return file location
    case emptyBookmarksFile(String) // return file location
    case improperBookmarkData
}

public protocol BookmarkParser {
    associatedtype BookmarkType

    func getBookmarkData(from bookmarksFilePath: String) throws -> Data
    func parse(_ bookmarksDump: Data) throws -> BookmarkType
    func convert<ItemType: OnebookItem>(_ bookmark: ItemType) throws -> BookmarkType
    func convert<ItemType: OnebookItem>(_ bookmark: [ItemType]) throws -> [BookmarkType]
}

// INTERNAL FUNCTIONS
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
