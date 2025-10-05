import '../models/usuario.dart';

abstract class AuthRepository {
  Future<Usuario> login(String email, String senha); // Login
  Future<Usuario> signUp(String nome, String email, String senha); // Cadastro
  Future<void> logout(); // Logout
  Future<bool> isLoggedIn(); // Verifica se o usuário está autenticado
}
