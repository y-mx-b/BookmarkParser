# Constants

BookmarkParser contains three primary public constants not utilized in
BookmarkParser itself (for now): the `bookmarkPaths` dictionary, the `Browser`
enum, and the `FormatTypes` enum.

## Enums

### Browser

This enum is implemented just as shown below:

```swift
public enum Browser: String {
    case chromium
    case chrome
    case brave
    case edge
    case safari
    case firefox
    case qutebrowser
}
```

It's an enum containing one case for each (to be) supported browser. They all
have raw values equivalent to their name.

### FormatTypes

This enum is implemented just as shown below:

```swift
public enum FormatTypes: String {
    case html
    case json
    case plist
    case sqlite
    case onebook
}
```

It's an enum containing one case for each (to be) supported format. They all
have raw values equivalent to their name.

## bookmarkPaths

The `bookmarkPaths` dictionary has a separate implementation for each operating
system. It's a dictionary of type `[Browser : String]`, containing one file
path for each browser case. The file path stored is simply the default
bookmarks file path for each browser.
