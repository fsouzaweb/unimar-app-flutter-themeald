import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/recipe_controller.dart';
import 'views/splash_screen.dart';
import 'views/recipe_list_screen.dart';
import 'views/favorites_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RecipeController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receitas',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // Define a SplashScreen como a tela inicial
      routes: {
        '/recipes': (context) =>
            const RecipeListScreen(), // Atualiza para nome mais claro
        '/favorites': (context) => const FavoritesScreen(),
      },
    );
  }
}
