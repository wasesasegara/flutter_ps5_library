# flutter_ps5_library

A small project to see Sony Play Station 5 games in last one year.

## Features

- PS5 games library updated with RAWG API
- On list
  - Shows image, name, release date, and rating if available
  - Pagination
  - Grid view
  - Pull to refresh
  - Button scroll to top
- On detail
  - Brings existing data from list, and update with detail API
  - Shows image, game name, developer name, platforms, rating, release date,
    description, updated at, screenshots, game website.
  - On top navigation hidden, shows when scroll to bottom
  - Game description parsed from html format
  - Screenshot collection horizontal swipable and has dot indicators
  - When fetching, content that not available yet shimmers

## Getting Started

To make app run normally, fill your RAWG API key in `lib/api/api_config.dart`

## Test Coverage

Test coverage 53.1% because I'm struggling to get the screen widget that consume 
`ChangeNotifierProvider` works yet.

Evidence:

![image](https://github.com/wasesasegara/flutter_ps5_library/assets/39652855/5293bacd-ee0d-49dd-befc-67f1059197c4)

## Preview

https://github.com/wasesasegara/flutter_ps5_library/assets/39652855/8e62e611-eb7b-44f7-ad1a-a060e87177e6


