# BookmarkParser

A Swift library for working with bookmarks from various browsers.

NOTE: Currently, only Chromium-based browsers and Safari are supported.

## Using BookmarkParser

First, include this line in your `Package.swift` file, under `dependencies`

```swift
.package(url: "https://github.com/luardemin/BookmarkParser", .branch("master"))
```

Then, add the following under `.target` in `dependencies`:

```swift
.product(name: "BookmarkParser", package: "BookmarkParser")
```

Then simply `import BookmarkParser` and you're done!

For more information, check the [documentation folder](./Documentation/).
