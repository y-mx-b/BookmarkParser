import Foundation

struct ChromiumBookmarkParser: BrowserBookmarkParser {
    typealias BookmarkType = ChromiumBookmarks

    let browser: [Browser] = [.chromium, .chrome, .brave, .edge]
    let format: FormatTypes = .json

    func getBookmarks(from bookmarksFilePath: String, browser: Browser) throws -> Data {
        let fm = FileManager.default

        switch browser {
        case .chromium, .chrome, .brave, .edge:
            break
        default:
            throw BookmarkParserError.invalidBrowser(browser)
        }

        guard fm.fileExists(atPath: bookmarksFilePath)
            else { throw BookmarkParserError.noBookmarkFile(bookmarksFilePath) }
        guard let contents = fm.contents(atPath: bookmarksFilePath)
            else { throw BookmarkParserError.emptyBookmarksFile(bookmarksFilePath) }

        return contents
    }

    func parseBookmarks(_ bookmarksDump: Data, from browser: Browser) throws -> BookmarkType {
        switch browser {
        case .chromium, .chrome, .brave, .edge:
            break
        default:
            throw BookmarkParserError.invalidBrowser(browser)
        }

        guard let bookmarks = try? JSONDecoder().decode(BookmarkType.self, from: bookmarksDump)
            else { throw BookmarkParserError.improperBookmarkData }

        return bookmarks
    }

    func returnBookmarks(_ bookmarks: BookmarkType) -> [OnebookChildren]? {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()

        let bookmark_bar_data = try! encoder.encode(bookmarks.roots.bookmark_bar)
        let other_data = try! encoder.encode(bookmarks.roots.other)
        let synced_data = try! encoder.encode(bookmarks.roots.synced)

        let bookmarkBar = try! decoder.decode(OnebookChildren.self, from: bookmark_bar_data)
        let other = try! decoder.decode(OnebookChildren.self, from: other_data)
        let synced = try! decoder.decode(OnebookChildren.self, from: synced_data)

        return [bookmarkBar, other, synced]
    }

    func convertBookmarks(_ bookmarks: Data, to format: FormatTypes) throws -> BookmarkType? {
        guard format == .json else { throw BookmarkParserError.invalidFormatType(format) }
        return nil
    }
}
