# Extra Projects

These projects are not part of the main 100 Days of Swift/SwiftUI series, but are part of @twostraws's Hacking with Swift series.

They are designed to help you learn more about Swift and SwiftUI, and are a great way to expand your skills.

## [FaceFacts](https://www.hackingwithswift.com/articles/263/build-your-first-app-with-swiftui-and-swiftdata)

This project is focus on building and app with SwiftUI and SwiftData.

[Project Code](FaceFacts)

### Notes

- The [`Previewer`](FaceFacts/FaceFacts/Models/Previewer.swift) custom _class_ is used to preview the app in the Xcode Previews. It's a simple class that has a container object, which is used to store SwiftData database in memory.
  - The [`@MainActor`](https://developer.apple.com/documentation/swift/mainactor) _attribute_ is used to make sure that the `Previewer` class is always accessed from the main thread. This makes easy to access the `mainContext` attribute of the container object.
- The [`@Attribute`](<https://developer.apple.com/documentation/swiftdata/attribute(_:originalname:hashmodifier:)/>) _macro_ tells SwiftData that the property should be stored outside the database an keeps a reference to the file inside the database.
- Use [`PhotosPickerItem`](https://developer.apple.com/documentation/photokit/photospickeritem/) to select an image from the photos library and save it to the database.
- _CloudKit_ to sync data using SwiftData.
  - Go into _FaceFacts_ target > Signing & Capabilities_
  - Add _iCloud_ capability (click on the `+ Capability` button and search for _iCloud_):
    - Select the _CloudKit_ checkbox.
    - Add the _iCloud container_ (Create a new one or select an existing one).
  - Add _Background Modes_ capability:
    - Select _Remote notifications_.

### Sources

- [Hacking with Swift - Build your first app with SwiftUI and SwiftData](https://www.hackingwithswift.com/articles/263/build-your-first-app-with-swiftui-and-swiftdata)
- [@twostraws GitHub - FaceFacts](https://github.com/twostraws/FaceFacts)
