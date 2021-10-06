public struct OnebookChildren {
    let name: String
    let url: String?
    let folders: [OnebookChildren?]
    let bookmarks: [OnebookChildren?]
}

public struct OnebookBookmarks {
    let folders: [OnebookChildren?]
}
