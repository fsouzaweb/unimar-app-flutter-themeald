import 'package:flutter/material.dart';
import 'recipe_list_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  // Função para navegar automaticamente para a tela principal após alguns segundos
  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const RecipeListScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent, // Cor de fundo da tela de splash
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png', // Certifique-se de adicionar a imagem 'logo.png' na pasta assets
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
