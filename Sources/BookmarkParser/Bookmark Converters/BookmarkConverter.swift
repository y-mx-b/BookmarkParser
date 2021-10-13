public struct BookmarkConverter {
    func convert<BookmarkType: OnebookItem>(_ bookmark: BookmarkType) -> OnebookChildren? {
        guard let _ = bookmark.children else {
            return OnebookChildren(name: bookmark.name, url: bookmark.url, children: nil)
        }
        return OnebookChildren(name: bookmark.name, url: bookmark.url, children: convert(bookmark.children!))
    }

    func convert<BookmarkType: OnebookItem>(_ bookmarks: [BookmarkType]) -> [OnebookChildren] {
        let array: () -> [OnebookChildren] = {
            var outputBookmarks: [OnebookChildren] = []
            for bookmark in bookmarks {
                let name = bookmark.name
                let url = bookmark.url
                let children: () -> [OnebookChildren]? = {
                    var output: [OnebookChildren]? = []
                    guard let array = bookmark.children else { return nil }
                    for child in array {
                        if let _ = child.children {
                            output!.append(OnebookChildren(name: child.name, url: child.url, children: nil))
                        }
                        output!.append(OnebookChildren(name: child.name, url: child.url,
                                                       children: convert(child.children!)))
                    }
                    return output
                }
                outputBookmarks.append(OnebookChildren(name: name, url: url, children: children()))
            }
            return outputBookmarks
        }
        return array()
    }

    func convert<BookmarkType: OnebookItem>(_ bookmarks: OnebookChildren, to output: FormatTypes) -> BookmarkType? {
        return nil
    }

}

