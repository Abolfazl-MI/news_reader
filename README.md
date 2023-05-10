# News Reader App

This is a Flutter app that allows users to read news from various sources. The app utilizes a clean architecture approach with the BLoC pattern to manage the app's state. The app also implements various dependencies such as the Dio HTTP client, Hive database, and shared_preferences for data storage.

## Architecture

The app utilizes a clean architecture approach, which separates the app into three main layers: presentation, domain, and data.

### Presentation Layer

The presentation layer is responsible for displaying the UI and handling user interactions. In this app, the presentation layer is built using the Flutter framework and implements the BLoC pattern to manage the app's state. The BLoC pattern separates the business logic from the UI, making the codebase more organized and easier to maintain.

### Domain Layer

The domain layer defines the business rules and use cases of the app. In this app, the domain layer consists of the interfaces and the models used by the presentation and data layers.

### Data Layer

The data layer is responsible for retrieving and storing data used by the app. In this app, the data layer utilizes the Dio HTTP client to retrieve news data from various sources and the Hive database to store the data locally. The data layer also uses shared_preferences to store user preferences such as the user's selected news sources.

## Dependencies

This app utilizes the following dependencies:

- dio: An HTTP client for making API requests
- hive: A lightweight and fast key-value database
- shared_preferences: A package for storing data on the device

## Conclusion

Overall, this News Reader app utilizes a clean architecture approach with the BLoC pattern to create a well-organized and maintainable codebase. The app also utilizes various dependencies such as Dio, Hive, and shared_preferences to retrieve and store data used by the app.