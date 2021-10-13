public enum BookmarkConversionError: Error {
    case invalidFormatType(FormatTypes)
}
public struct BookmarkConverter {
    func convert<BookmarkType: OnebookItem>(_ bookmark: BookmarkType) -> OnebookChildren {
        return OnebookChildren(name: bookmark.name, url: bookmark.url, children: convert(bookmark.children ?? []))
    }

    func convert<BookmarkType: OnebookItem>(_ bookmarks: [BookmarkType]) -> [OnebookChildren] {
        var outputBookmarks: [OnebookChildren] = []
        for bookmark in bookmarks {
            outputBookmarks.append(convert(bookmark))
        }
        return outputBookmarks
    }

    func convert(_ bookmark: OnebookChildren, to format: FormatTypes) throws -> Any {
        switch format {
        case .json:
            return ChromiumChildren(name: bookmark.name, url: bookmark.url,
                                    children: try convert(bookmark.children ?? [], to: format) as? [ChromiumChildren])
        case .plist:
            return SafariChildren(name: bookmark.name, url: bookmark.url,
                                  children: try convert(bookmark.children ?? [], to: format) as? [SafariChildren])
        default:
            throw BookmarkConversionError.invalidFormatType(format)
        }
    }

    func convert(_ bookmarks: [OnebookChildren], to format: FormatTypes) throws -> [Any] {
        switch format {
        case .json:
            var outputBookmarks: [ChromiumChildren] = []
            for bookmark in bookmarks {
                outputBookmarks.append(try convert(bookmark, to: format) as! ChromiumChildren)
            }
            return outputBookmarks
        case .plist:
            var outputBookmarks: [SafariChildren] = []
            for bookmark in bookmarks {
                outputBookmarks.append(try convert(bookmark, to: format) as! SafariChildren)
            }
            return outputBookmarks
        default:
            throw BookmarkConversionError.invalidFormatType(format)
        }
    }

}

