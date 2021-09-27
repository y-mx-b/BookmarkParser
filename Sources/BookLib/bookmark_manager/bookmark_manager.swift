import Foundation

public struct BookmarkManager {
    // TODO remove hard-coded bookmarks directory
    public var browserName: String?
    public var bookmarksFilePath: String?
    public var storageDirectory = "\(NSHomeDirectory())/.bookmarks/"
}
