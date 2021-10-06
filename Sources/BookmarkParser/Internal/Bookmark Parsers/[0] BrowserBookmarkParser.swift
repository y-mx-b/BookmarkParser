import Foundation

protocol BrowserBookmarkParser {
    associatedtype BookmarkType
    func getBookmarks(from bookmarksFilePath: URL) -> Data?
    func parseBookmarks(_ bookmarksDump: Data?) -> BookmarkType?
    func returnBookmarks(_ bookmarks: BookmarkType?) -> OnebookBookmarks?
}
