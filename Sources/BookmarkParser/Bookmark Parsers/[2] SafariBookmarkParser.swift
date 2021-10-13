import Foundation

public struct SafariBookmarkParser: BookmarkParser {
    public typealias BookmarkType = SafariChildren

    public func getBookmarkData(from bookmarksFilePath: String, format: FormatTypes = .plist) throws -> Data {
        let fm = FileManager.default

        guard format == .plist else {
            throw BookmarkParserError.invalidFormatType(format)
        }
        guard fm.fileExists(atPath: bookmarksFilePath) else {
            throw BookmarkParserError.noBookmarkFile(bookmarksFilePath)
        }
        guard let contents = fm.contents(atPath: bookmarksFilePath) else {
            throw BookmarkParserError.emptyBookmarksFile(bookmarksFilePath)
        }

        return contents
    }

    public func parse(_ bookmarksDump: Data, format: FormatTypes = .plist) throws -> BookmarkType {
        guard format == .plist else {
            throw BookmarkParserError.invalidFormatType(format)
        }
        guard let bookmarks = try? PropertyListDecoder().decode(BookmarkType.self, from: bookmarksDump) else {
            throw BookmarkParserError.improperBookmarkData
        }

        return bookmarks
    }
}
