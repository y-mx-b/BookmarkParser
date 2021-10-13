import Foundation

public struct OnebookBookmarkParser: BookmarkParser {
    public typealias BookmarkType = OnebookChildren

    public func getBookmarkData(from bookmarksFilePath: String, format: FormatTypes = .onebook) throws -> Data {
        let fm = FileManager.default

        guard format == .onebook else {
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

    public func parse(_ bookmarksDump: Data, format: FormatTypes = .onebook) throws -> BookmarkType {
        guard format == .onebook else {
            throw BookmarkParserError.invalidFormatType(format)
        }
        guard let bookmarks = try? JSONDecoder().decode(BookmarkType.self, from: bookmarksDump) else {
            throw BookmarkParserError.improperBookmarkData
        }

        return bookmarks
    }

    public func convert<ItemType: OnebookItem>(_ bookmark: ItemType, to format: FormatTypes = .onebook) throws -> BookmarkType {
        guard format == .onebook else { throw BookmarkConversionError.invalidFormatType(format) }
        return OnebookChildren(name: bookmark.name, url: bookmark.url,
                               children: try convert(bookmark.children ?? [], to: format))
    }

    public func convert<ItemType: OnebookItem>(_ bookmarks: [ItemType], to format: FormatTypes = .onebook) throws -> [BookmarkType] {
        guard format == .onebook else { throw BookmarkConversionError.invalidFormatType(format) }
        var outputBookmarks: [BookmarkType] = []
        for bookmark in bookmarks {
            outputBookmarks.append(try convert(bookmark, to: format))
        }
        return outputBookmarks
    }
}
