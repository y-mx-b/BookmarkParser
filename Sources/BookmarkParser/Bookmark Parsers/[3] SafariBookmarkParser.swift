import Foundation

public struct SafariBookmarkParser: BookmarkParser {
    public typealias BookmarkType = SafariChildren

    public func getBookmarkData(from bookmarksFilePath: String) throws -> Data {
        return try getBookmarkContents(from: bookmarksFilePath)
    }

    public func parse(_ bookmarksDump: Data)throws -> BookmarkType {
        guard let bookmarks = try? PropertyListDecoder().decode(BookmarkType.self, from: bookmarksDump) else {
            throw BookmarkParserError.improperBookmarkData
        }

        return bookmarks
    }

    public func convert<ItemType: OnebookItem>(_ bookmark: ItemType) throws -> BookmarkType {
        return SafariChildren(name: bookmark.name, url: bookmark.url,
                                children: try convert(bookmark.children ?? []))
    }

    public func convert<ItemType: OnebookItem>(_ bookmarks: [ItemType]) throws -> [BookmarkType] {
        var outputBookmarks: [SafariChildren] = []
        for bookmark in bookmarks {
            outputBookmarks.append(try convert(bookmark))
        }
        return outputBookmarks
    }
}
