import Foundation

protocol BrowserBookmarkParser {
    associatedtype BookmarkType: Codable
    func getBookmarks(from bookmarksFilePath: String) throws -> Data
    func parseBookmarks(_ bookmarksDump: Data) throws -> BookmarkType
    func returnBookmarks(_ bookmarks: BookmarkType) throws -> OnebookBookmarks?
    // remove optional later
}
