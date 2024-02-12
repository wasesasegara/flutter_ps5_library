import 'package:flutter/material.dart';
import 'package:flutter_ps5_library/feature/games/state/games_provider.dart';
import 'package:flutter_ps5_library/feature/games/view/games_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(appProviders);
}

MultiProvider get appProviders {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => GamesProvider()),
    ],
    child: const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GamesScreen(),
    );
  }
}
