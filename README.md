# Places

## Screenshots
![screen4](https://github.com/user-attachments/assets/082dc45a-14cc-46ca-8c42-e398ca8b2f01)
![screen2](https://github.com/user-attachments/assets/1acf63cc-0ead-4ba2-b49c-3b297bb1ada7)
![screen3](https://github.com/user-attachments/assets/76eee10a-5e37-487d-9b1f-69fa9b0aaa81)

## Demo
https://github.com/user-attachments/assets/b4cd899e-db6b-4a75-b1d1-f3b19f3e6332

## Overview

The Places app fetches and displays a list of locations. Users can select a location from the list to open the Wikipedia app directly in the 'Places' tab, showing the selected location. Additionally, users can enter a search query and open the Wikipedia app to view information about a custom location based on their search.

**Note**: To use the Places app and successfully open the Wikipedia app via deep links, you need to clone and run the forked version of the Wikipedia app on the same device or simulator. You can find the forked and updated version of the Wikipedia app at https://github.com/stasprigodich/wikipedia-ios.

The Places app uses 2 **deep link** formats:

- "wikipedia://places?lat=52.379189&lon=4.899431" for coordinates
- "wikipedia://places?WMFArticleURL=https://en.wikipedia.org/wiki/Warsaw" for a custom search query

## Technologies
**Xcode**: 15.4

**Language**: Swift 5.10

**iOS version**: 16.0+

**Architecture**: VIPER

**UI**: SwiftUI

**Concurrency**: Swift Concurrency (async/await)

**Testing**: Unit Tests using XCTest

**Localization**: English and Spanish

**Device support**: iPhone, iPad, Mac, Apple Vision

**Accessibility**: Full support for VoiceOver, Dynamic Type, and custom accessibility identifiers

**Theme**: Light and Dark

## Project structure
<img width="430" alt="project-struct" src="https://github.com/user-attachments/assets/55fda18d-0c18-4e75-bd32-b909c225f262">




