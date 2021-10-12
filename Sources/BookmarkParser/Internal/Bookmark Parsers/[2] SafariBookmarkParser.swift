import Foundation

struct SafariBookmarkParser: BrowserBookmarkParser {
    typealias BookmarkType = SafariChildren

    // let browser: [Browser] = [.safari]
    // let format: FormatTypes = .plist

    func getBookmarks(from bookmarksFilePath: String, browser: Browser = .safari) throws -> Data {
        let fm = FileManager.default

        guard browser == .safari else { throw BookmarkParserError.invalidBrowser(browser) }
        guard fm.fileExists(atPath: bookmarksFilePath)
            else { throw BookmarkParserError.noBookmarkFile(bookmarksFilePath) }
        guard let contents = fm.contents(atPath: bookmarksFilePath)
            else { throw BookmarkParserError.emptyBookmarksFile(bookmarksFilePath) }

        return contents
    }

    func parseBookmarks(_ bookmarksDump: Data, from browser: Browser = .safari) throws -> BookmarkType {
        guard browser == .safari else { throw BookmarkParserError.invalidBrowser(browser) }
        guard let bookmarks = try? PropertyListDecoder().decode(BookmarkType.self, from: bookmarksDump)
            else { throw BookmarkParserError.improperBookmarkData }

        return bookmarks
    }

    func returnBookmarks(_ bookmarks: BookmarkType) -> [OnebookChildren]? {
        return nil
    }

    func convertBookmarks(_ bookmarks: Data, to format: FormatTypes) throws -> BookmarkType? {
        guard format == .plist else { throw  BookmarkParserError.invalidFormatType(format) }
        return nil
    }
}
