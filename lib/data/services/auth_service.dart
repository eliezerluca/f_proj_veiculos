import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<Session> login(String email, String senha) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: senha,
      );

      if (response.session == null) {
        throw Exception('Erro ao fazer login: Sessão não foi criada.');
      }

      return response.session!; // Retorna a sessão do usuário autenticado
    } on AuthException catch (e) {
      throw Exception('Erro ao fazer login: ${e.message}');
    } catch (e) {
      throw Exception('Erro inesperado ao fazer login: $e');
    }
  }

  Future<User> signUp(String nome, String email, String senha) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: senha,
        data: {
          'nome_completo': nome,
        }, // Salva o nome completo no metadata do usuário
      );

      if (response.user == null) {
        throw Exception('Erro ao criar conta: Usuário não foi criado.');
      }

      return response.user!; // Retorna o usuário recém-criado
    } on AuthException catch (e) {
      throw Exception('Erro ao criar conta: ${e.message}');
    } catch (e) {
      throw Exception('Erro inesperado ao criar conta: $e');
    }
  }

  Future<void> logout() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw Exception('Erro ao fazer logout: $e');
    }
  }

  Future<bool> isLoggedIn() async {
    return _supabase.auth.currentSession != null;
  }
}
