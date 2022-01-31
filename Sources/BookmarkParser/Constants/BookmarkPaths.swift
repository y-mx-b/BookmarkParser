import Foundation

#if os(macOS)
    public let bookmarkPaths: [Browser: String] = [
        .chromium: "\(NSHomeDirectory())/Library/Application Support/Chromium/Default/Bookmarks",
        .chrome: "\(NSHomeDirectory())/Library/Application Support/Google/Chrome/Default/Bookmarks",
        .brave: "\(NSHomeDirectory())/Library/Application Support/BraveSoftware/Brave-Browser/Default/Bookmarks",
        .edge: "",
        .safari: "\(NSHomeDirectory())/Library/Safari/Bookmarks.plist",
        .firefox: "",
        .qutebrowser: "",
    ]
#elseif os(Linux)
    public let bookmarkPaths: [Browser: String] = [
        .chromium: "\(NSHomeDirectory())/.config/chromium/Default/Bookmarks",
        .chrome: "\(NSHomeDirectory())/.config/google-chrome/Default/Bookmarks",
        .brave: "\(NSHomeDirectory())/.config/BraveSoftware/Brave-Browser/Default/Bookmarks",
        .edge: "",
        .safari: "",
        .firefox: "",
        .qutebrowser: "",
    ]
#endif
