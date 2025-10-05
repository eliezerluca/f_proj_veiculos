import 'package:flutter/material.dart';
import 'package:proj_veiculos/data/repositories/auth_repository_impl.dart';
import 'package:proj_veiculos/data/services/auth_service.dart';
import 'package:proj_veiculos/ui/controllers/auth_controller.dart';
import 'package:proj_veiculos/ui/screens/auth/sign_in.dart';
import '../../core/themes/app_theme.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final AuthController authController;

  @override
  void initState() {
    super.initState();
    final authService = AuthService();
    final authRepository = AuthRepositoryImpl(authService);
    authController = AuthController(authRepository);
    authController.addListener(_onAuthStateChanged);
  }

  @override
  void dispose() {
    authController.removeListener(_onAuthStateChanged);
    authController.dispose();
    super.dispose();
  }

  void _onAuthStateChanged() {
    if (authController.value == AuthState.unauthenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignIn()),
      );
    }
  }

  Future<void> _handleLogout() async {
    await authController.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proj Veículos'),
        centerTitle: true,
        actions: [
          ValueListenableBuilder<AuthState>(
            valueListenable: authController,
            builder: (context, state, child) {
              return IconButton(
                onPressed: state == AuthState.loading ? null : _handleLogout,
                icon: state == AuthState.loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.logout),
                tooltip: 'Logout',
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.home,
              size: 100,
              color: AppTheme.secondaryColor,
            ),
            SizedBox(height: 20),
            Text(
              'Bem-vindo ao Proj Veículos!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.lightTextColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Você está logado com sucesso',
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.lightTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
