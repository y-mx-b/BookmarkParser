import Foundation

public struct ChromiumBookmarkParser: BookmarkParser {
    public typealias BookmarkType = ChromiumChildren

    public func getBookmarkData(from bookmarksFilePath: String, format: FormatTypes = .json) throws -> Data {
        let fm = FileManager.default

        guard format == .json else {
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

    public func parse(_ bookmarksDump: Data, format: FormatTypes = .json) throws -> BookmarkType {
        guard format == .json else {
            throw BookmarkParserError.invalidFormatType(format)
        }
        guard let bookmarks = try? JSONDecoder().decode(BookmarkType.self, from: bookmarksDump) else {
            throw BookmarkParserError.improperBookmarkData
        }

        return bookmarks
    }

    public func convert<ItemType: OnebookItem>(_ bookmark: ItemType, to format: FormatTypes = .json) throws -> BookmarkType {
        guard format == .json else { throw BookmarkConversionError.invalidFormatType(format) }
        return ChromiumChildren(name: bookmark.name, url: bookmark.url,
                                children: try convert(bookmark.children ?? [], to: format))
    }

    public func convert<ItemType: OnebookItem>(_ bookmarks: [ItemType], to format: FormatTypes = .json) throws -> [BookmarkType] {
        guard format == .json else { throw BookmarkConversionError.invalidFormatType(format) }
        var outputBookmarks: [ChromiumChildren] = []
        for bookmark in bookmarks {
            outputBookmarks.append(try convert(bookmark, to: format))
        }
        return outputBookmarks
    }
}
