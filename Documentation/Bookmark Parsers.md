# Bookmark Parsers

There are currently only three parsers: `OnebookBookmarkParser`,
`ChromiumBookmarkParser`, and `SafariBookmarkParser`.

Each parser follows the `BookmarkParser` protocol, which is shown below:

```swift
public protocol BookmarkParser {
    associatedtype BookmarkType

    func getBookmarkData(from bookmarksFilePath: String) throws -> Data
    func parse(_ bookmarksDump: Data) throws -> BookmarkType
    func convert<ItemType: OnebookItem>(_ bookmark: ItemType) throws -> BookmarkType
    func convert<ItemType: OnebookItem>(_ bookmark: [ItemType]) throws -> [BookmarkType]
}
```

As such, each of the three parsers have the exact same functionality, only
functionality, only differing in the fact that they work with different
bookmark different bookmark types. The bookmark types are explained in
[Constants.md](./Constants.md).

## Methods

`getBookmarksData(from:)` will return the contents of the bookmark file
supplied.

`parse()` will return the data supplied to it as the bookmark type
corresponding to the parser. Each parser has its own `BookmarkType` type alias.

`convert()` will return either a single `BookmarkType` struct or an array of
them depending on whether it was supplied a single struct or an array.

## Errors

Every method can throw, and there are two enums with error cases in this
library: `BookmarkParserError` and `BookmarkConversionError`. They are
implemented as such:

```swift
public enum BookmarkParserError: Error {
    case noBookmarkFile(String)
    case emptyBookmarksFile(String)
    case improperBookmarkData
    case invalidBrowser(Browser)
    case invalidFormatType(FormatTypes)
}

public enum BookmarkConversionError: Error {
    case invalidFormatType(FormatTypes)
}
```

There are no localized descriptions provided, so the two enums can be extended
to make custom localized descriptions.
