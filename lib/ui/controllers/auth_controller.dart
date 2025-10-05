import 'package:flutter/material.dart';
import 'package:proj_veiculos/domain/models/usuario.dart';
import 'package:proj_veiculos/domain/repositories/auth_repository.dart';

enum AuthState { initial, loading, authenticated, unauthenticated, error }

class AuthController extends ValueNotifier<AuthState> {
  final AuthRepository _authRepository;

  Usuario? _currentUser;
  String? _errorMessage;

  AuthController(this._authRepository) : super(AuthState.initial);

  Usuario? get currentUser => _currentUser;
  String? get errorMessage => _errorMessage;

  // Verifica se o usuário já está logado
  Future<void> checkAuthState() async {
    value = AuthState.loading;

    try {
      final isLoggedIn = await _authRepository.isLoggedIn();
      if (isLoggedIn) {
        // Se estiver logado, você pode recuperar os dados do usuário atual
        // Por enquanto, vamos apenas definir como autenticado
        value = AuthState.authenticated;
      } else {
        value = AuthState.unauthenticated;
      }
    } catch (e) {
      _errorMessage = e.toString();
      value = AuthState.error;
    }
  }

  // Função para fazer login
  Future<void> login(String email, String password) async {
    value = AuthState.loading;

    try {
      _currentUser = await _authRepository.login(email, password);
      _errorMessage = null;
      value = AuthState.authenticated;
    } catch (e) {
      _errorMessage = e.toString();
      value = AuthState.error;
    }
  }

  // Função para fazer cadastro
  Future<void> signUp(String name, String email, String password) async {
    value = AuthState.loading;

    try {
      _currentUser = await _authRepository.signUp(name, email, password);
      _errorMessage = null;
      value = AuthState.authenticated;
    } catch (e) {
      _errorMessage = e.toString();
      value = AuthState.error;
    }
  }

  // Função para fazer logout
  Future<void> logout() async {
    value = AuthState.loading;

    try {
      await _authRepository.logout();
      _currentUser = null;
      _errorMessage = null;
      value = AuthState.unauthenticated;
    } catch (e) {
      _errorMessage = e.toString();
      value = AuthState.error;
    }
  }

  // Limpa mensagens de erro
  void clearError() {
    _errorMessage = null;
    if (value == AuthState.error) {
      value = AuthState.unauthenticated;
    }
  }
}
