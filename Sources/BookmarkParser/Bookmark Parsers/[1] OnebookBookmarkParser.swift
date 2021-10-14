import Foundation

public struct OnebookBookmarkParser: BookmarkParser {
    public typealias BookmarkType = OnebookChildren

    public func getBookmarkData(from bookmarksFilePath: String) throws -> Data {
        return try getBookmarkContents(from: bookmarksFilePath)
    }

    public func parse(_ bookmarksDump: Data) throws -> BookmarkType {
        guard let bookmarks = try? JSONDecoder().decode(BookmarkType.self, from: bookmarksDump) else {
            throw BookmarkParserError.improperBookmarkData
        }

        return bookmarks
    }

    public func convert<ItemType: OnebookItem>(_ bookmark: ItemType) throws -> BookmarkType {
        return OnebookChildren(name: bookmark.name, url: bookmark.url,
                               children: try convert(bookmark.children ?? []))
    }

    public func convert<ItemType: OnebookItem>(_ bookmarks: [ItemType]) throws -> [BookmarkType] {
        var outputBookmarks: [BookmarkType] = []
    for bookmark in bookmarks {
        outputBookmarks.append(try convert(bookmark))
        }
        return outputBookmarks
    }
}
