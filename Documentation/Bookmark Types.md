# Bookmark Types

There are currently only three implemented structs: `OnebookChildren`,
`ChromiumChildren`, and `SafariChildren`.

Because bookmark files are actually rather complex, browser-dependent bookmark
structs are represented by multiple structs that all comply with the `Codable`
protocol.

Each one of these item structs can represent either a bookmark or a folder, and
they all share a common public initialization format: `init(name: String, url:
String?, children: [ItemType]?)`

The `ItemType` type is a type alias equivalent to the corresponding item
struct.

Most importantly, all three of these structs adhere to the `OnebookItem`
protocol, which is shown below:

```swift
public protocol OnebookItem {
    associatedtype ItemType: OnebookItem
    var name: String { get }
    var url: String? { get }
    var children: [ItemType]? { get }
}
```

Therefore, all three structs contain variables `name`, `url`, and `children`,
although `url` and `children` may return nil (`url` is only present in
bookmarks, and `children` stores folders/bookmarks in a folder.)

These are also the only values contained in the `OnebookChildren` struct.

## Chromium

Chromium bookmarks are JSON files structured like the following:

```json
{
   "checksum": "[md5]",
   "roots": {
      "bookmark_bar": {
            children": {
               "children": {},
               "date_added": "",
               ...
            },
            "date_added": "[Unix time in nanoseconds]",
            "date_modified": "[Unix time in nanoseconds. Only present for folders]",
            "guid": "[GUID]",
            "id": "[Integer id]"
            "name": "[bookmark/folder name]",
            "type": "[folder/url]",
            "url": "[URL, only present for bookmarks]"
      },
      "other": {...},
      "synced": {...},
   },
   "version": [integer]
}
```

As such, they are represented in this library with three structs:
`ChromiumBookmarks`, `ChromiumChildren`, and `Roots`. `ChromiumBookmarks`
contains only one property (as it's the only relevant value, currently):
`roots`, which is of type `Roots`. `Roots` contains `bookmark_bar`, `other`,
and `synced`. Each are of type `ChromiumChildren`, as they all contain data of
equivalent structure. What they contain exactly is as can be assumed from their
names.

`ChromiumChildren` is the most complicated one. Currently, the struct only
contains stored values matching `children`, `name`, and `url`, with`children`
and `url` being optional values because they can be missing from specific child
items, as mentioned earlier.

## Safari

Safari bookmarks are binary property list files (you can convert them to other
formats using `plutil` from the terminal). Their structure is rather complex
(the normal text representation is XML, and there's still a lot of what I would
assume is binary data encoded into ASCII), and I'm not too sure of everything
contained in them (I would like to be able to generate valid Safari bookmarks
files eventually, so this will require further research). Regardless, Safari
bookmarks are represented with two structs: `SafariChildren` and
`SafariURIDictionary`.

`SafariChildren`, currently stores only values equivalent to whatever is stored
in `ChromiumChildren`. Therefore, it stores only the following: `Title`,
`Children`, `URLString`, and `URIDictionary`. It also contains the calculated
properties `name`, `url`, and `children` in order to conform to the
`OnebookItem` protocol. Meanwhile, the `URIDictionary` struct only contains
`title` (this is true of the struct and the bookmark file).

`Title` is value containing the name of the item, but is only present in
folders.  Otherwise, `URIDictionary` will be present in bookmarks and will
contain `title`. Thus, both are optional values.

Just as `ChromiumChildren` did, `SafariChildren` also has the `Children`
property which can contain other instances of `SafariChildren`.
