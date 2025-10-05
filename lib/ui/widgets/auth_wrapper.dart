import 'package:flutter/material.dart';
import 'package:proj_veiculos/data/repositories/auth_repository_impl.dart';
import 'package:proj_veiculos/data/services/auth_service.dart';
import 'package:proj_veiculos/ui/controllers/auth_controller.dart';
import 'package:proj_veiculos/ui/screens/auth/sign_in.dart';
import 'package:proj_veiculos/ui/screens/home/home.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  late final AuthController authController;

  @override
  void initState() {
    super.initState();
    // Configuração das dependências
    final authService = AuthService();
    final authRepository = AuthRepositoryImpl(authService);
    authController = AuthController(authRepository);

    // Verifica o estado inicial de autenticação
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authController.checkAuthState();
    });
  }

  @override
  void dispose() {
    authController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AuthState>(
      valueListenable: authController,
      builder: (context, state, child) {
        switch (state) {
          case AuthState.loading:
          case AuthState.initial:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case AuthState.authenticated:
            return const Home();
          case AuthState.unauthenticated:
          case AuthState.error:
            return const SignIn();
        }
      },
    );
  }
}
