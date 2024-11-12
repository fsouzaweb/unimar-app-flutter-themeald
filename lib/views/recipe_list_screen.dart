import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe_model.dart';
import '../controllers/recipe_controller.dart';
import 'recipe_detail_screen.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  RecipeListScreenState createState() => RecipeListScreenState();
}

class RecipeListScreenState extends State<RecipeListScreen> {
  List<Recipe> _recipes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRecipes();
  }

  void _fetchRecipes() async {
    try {
      final controller = Provider.of<RecipeController>(context, listen: false);
      List<Recipe> recipes = await controller.fetchRecipes();
      setState(() {
        _recipes = recipes;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receitas'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _recipes.length,
              itemBuilder: (context, index) {
                Recipe recipe = _recipes[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 6.0,
                  ),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              recipe.image,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
                                              : null,
                                    ),
                                  );
                                }
                              },
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                return const Icon(
                                  Icons.broken_image,
                                  color: Colors.grey,
                                  size: 60,
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                              width: 16.0), // Espaço entre a imagem e o texto
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  recipe.name,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      RecipeDetailScreen(recipe: recipe),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    const begin = Offset(0.0, 1.0);
                                    const end = Offset.zero;
                                    const curve = Curves.easeInOut;

                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));
                                    var offsetAnimation =
                                        animation.drive(tween);

                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/favorites');
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.favorite, color: Colors.white),
        tooltip: 'Ver favoritos',
      ),
    );
  }
}
