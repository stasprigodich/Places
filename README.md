# Places

## Screenshots
![first-screen](https://github.com/user-attachments/assets/d575d57e-e2f2-43a1-b440-5714d5d30b0f)
![second-screen](https://github.com/user-attachments/assets/75aa857c-a7d1-4529-98a8-336444d9f14b)
![third-screen](https://github.com/user-attachments/assets/c4d36391-ca24-42ff-b2ba-5612719a131f)

## Demo
https://github.com/user-attachments/assets/47505dac-3a90-4a53-b760-b01abd4dc881

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
<img width="357" alt="Screenshot 2024-09-01 at 00 08 42" src="https://github.com/user-attachments/assets/7916cbe9-c319-4330-8ad8-d7c2a6e3716b">




