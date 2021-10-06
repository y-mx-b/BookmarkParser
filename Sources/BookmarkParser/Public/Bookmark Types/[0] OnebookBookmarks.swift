public struct OnebookChildren: Codable {
    let name: String
    let url: String?
    let folders: [OnebookChildren?]
    let bookmarks: [OnebookChildren?]
}

public struct OnebookBookmarks: Codable {
    let folders: [OnebookChildren?]
}
