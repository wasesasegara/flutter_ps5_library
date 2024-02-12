import 'package:flutter/material.dart';
import 'package:flutter_ps5_library/feature/game_detail/view/game_detail_screen.dart';
import 'package:flutter_ps5_library/feature/games/state/games_provider.dart';
import 'package:flutter_ps5_library/feature/games/view/games_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(appProviders);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PS5 Library',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

final MultiProvider appProviders = MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => GamesProvider()),
  ],
  child: const MyApp(),
);

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: GamesScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return const GamesScreen();
      },
      routes: [
        GoRoute(
          path: '${GamesScreen.routePath}/:id',
          name: GameDetailsScreen.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return GameDetailsScreen(
              id: state.pathParameters['id'],
              title: state.uri.queryParameters['title'],
            );
          },
        ),
      ],
    ),
  ],
);
