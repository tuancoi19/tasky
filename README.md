
## Intro
This repo base on management package is [flutter_bloc](https://pub.dev/packages/flutter_bloc).
The app has been setup to work with [retrofit](https://pub.dev/packages/retrofit), [dio](https://pub.dev/packages/dio), [json_annotation](https://pub.dev/packages/json_annotation), [intl_utils](https://pub.dev/packages/intl_utils) and [shimmer](https://pub.dev/packages/shimmer)

## Getting Started

1. Install [Flutter SDK](https://flutter.dev/docs/get-started/install). Require Flutter 3.0.5
2. Install plugins in Android Studio (optional)
   * [Dart Data Class](https://plugins.jetbrains.com/plugin/12429-dart-data-class)
   * [Flutter Intl](https://plugins.jetbrains.com/plugin/13666-flutter-intl)
   * [Bloc](https://plugins.jetbrains.com/plugin/12129-bloc)
4. Clone the repo.
5. Run `flutter pub get`
6. Run `flutter pub run intl_utils:generate`
7. Run `flutter pub run build_runner build --delete-conflicting-outputs`
8. Run app.

## File structure

```
assets
└───font
└───image
    └───2.0x
    └───3.0x
libs
└───bloc
│   └───app_cubit.dart
│   └───app_state.dart
└───common
│   └───app_colors.dart
│   └───app_dimens.dart
│   └───app_images.dart
│   └───app_shadows.dart
│   └───app_text_styles.dart
│   └───app_themes.dart
└───configs
│   └───app_configs.dart
└───database
│   └───secure_storage_helper.dart
│   └───shared_preferences_helper.dart
│   └───...
└───l10n
└───models
│   └───entities
│   │   └───user_entity.dart
│   │   └───...
│   └───enums
│   │   └───load_status.dart
│   │   └───...
│   └───params
│   │   └───sign_up_param.dart
│   │   └───...
│   └───response
│       └───array_response.dart
│       └───object_response.dart
└───networks
│   └───api_client.dart
│   └───api_interceptors.dart
│   └───api_util.dart
└───router
│   └───route_config.dart
└───repositories
│   └───auth_repository.dart
│   └───user_repository.dart.dart
│   └───...
└───ui
│   └───commons
│   │   └───app_bottom_sheet.dart
│   │   └───app_dialog.dart
│   │   └───app_snackbar.dart
│   │   └───...
│   └───pages
│   │   └───splash
│   │   │   └───splash_page.dart
│   │   │   └───splash_cubit.dart
│   │   │   └───splash_state.dart
│   │   └───...
│   └───widget //Chứa các widget base cho app
│       └───appbar
│       └───buttons
│       │   └───app_button.dart
│       │   └───app_icon_button.dart
│       │   └───...
│       └───images
│       │   └───app_cache_image.dart
│       │   └───app_circle_avatar.dart
│       └───textfields
│       └───shimmer
│       └───...
└───utils
│   └───date_utils.dart
│   └───file_utils.dart
│   └───logger.dart
│   └───utils.dart
│───main.dart
│───main_dev.dart //Config môi trường dev
└───main_staging.dart //Config môi trường production
```
| Item           | Explaint |
| -------------- | -------- |
| **main.dart**: | the "entry point" of program. |
| **assets**:    | store static assests like fonts and images. |
| **common**:    | contain colors, textStyle, theme, ... |
| **configs**:   | hold the configs of your application. |
| **database**:  | container database helper class |
| **l10n**:      | contain all localized string. [See more](https://flutter.dev/docs/development/accessibility-and-localization/internationalization) |
| **models**:    | contain entity, enum, .. |
| **networks**:  |
| **router**:    | contain the route navigation |
| **repositories**:    | contain repository |
| **ui**         |  |
| **utils**      |  |

```
