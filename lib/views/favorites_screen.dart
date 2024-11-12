import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/recipe_controller.dart';
import '../models/recipe_model.dart';
import 'recipe_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  FavoritesScreenState createState() => FavoritesScreenState();
}

class FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        centerTitle: true, // Alinha o título ao centro
      ),
      body: Consumer<RecipeController>(
        builder: (context, controller, child) {
          final _favorites = controller.getFavorites();
          return _favorites.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.sentiment_dissatisfied,
                          size: 80, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'Nenhuma receita favoritada.',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12.0),
                  itemCount: _favorites.length,
                  itemBuilder: (context, index) {
                    Recipe recipe = _favorites[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10.0),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              recipe.image,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            recipe.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.redAccent),
                            onPressed: () {
                              // Remove o favorito e mostra o Snackbar
                              controller.toggleFavorite(recipe);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Receita removida dos favoritos!'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                          ),
                          onTap: () {
                            // Navegar para a Tela de Detalhes
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RecipeDetailScreen(recipe: recipe),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
