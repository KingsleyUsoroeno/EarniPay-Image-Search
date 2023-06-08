# earnipay_image_search

## Getting Started

A flutter application to search for images from the unsplash api.

## How to Use

Download or clone this repo by using the link below:

```
https://github.com/KingsleyUsoroeno/EarniPay-Image-Search
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies:

```
flutter pub get 
```

**Step 3:**

This project uses `inject`  and the `json_annotation` library that works with code generation, execute the following command to generate files:

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

or watch command in order to keep the source code synced automatically:

```
flutter packages pub run build_runner watch
```

**Step 4:**

This project consists of two test files, one which tests that our widget `WidgetTest` renders the right Ui component
based on the appropriate state change `photo_search_screen_widget_test.dart` and a bloc test file
`Unit test` which tests that our `photo_search_cubit` renders the right state.

`To run all this test execute the following command in the project root directory flutter test`

## Table of Contents
* State Management
* Dependency Injection
* Networking
* Image Caching
* State Management


## Hydrated Bloc
[Hydrated Bloc](https://pub.dev/packages/hydrated_bloc) is a powerful state management library that allows automatic persistence and 
restoration of bloc and cubit states. It provides an easy way to preserve the state of your 
application across restarts or in scenarios where you need to persist and restore state. 
By using Hydrated Bloc, you can focus on building your application's logic without worrying 
about state persistence.



## Dependency Injection
[getIt](https://pub.dev/packages/get_it) and [injectable](https://pub.dev/packages/injectable) are popular dependency injection libraries for Flutter. Dependency 
injection helps to manage the dependencies of your application and enables easier testing 
and separation of concerns. getIt provides a simple service locator approach, 
while injectable is a code generator that simplifies the setup and usage of getIt.


## Networking

[Dio](https://github.com/flutterchina/dio) is a powerful HTTP client library for Flutter, inspired by the well-known Retrofit 
library for Android. It provides a simple and intuitive way to make HTTP requests 
and handle responses. Dio supports various features such as request cancellation, 
interceptors, file uploads, and more, making it an excellent choice 
for handling network requests in your Flutter project.


## Image Caching

[CacheNetworkImage](https://pub.dev/packages/CacheNetworkImage) is a Flutter library that simplifies image loading and caching 
from network sources. It efficiently caches images locally, reducing the need for repeated 
network requests and improving the performance of your application. By using CacheNetworkImage, 
you can effortlessly display and cache images from URLs in your Flutter project.


Happy coding! motion) 





