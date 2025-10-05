import 'package:proj_veiculos/domain/models/usuario.dart';
import 'package:proj_veiculos/domain/repositories/auth_repository.dart';
import 'package:proj_veiculos/data/services/auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl(this._authService);

  @override
  Future<Usuario> login(String email, String senha) async {
    final session = await _authService.login(email, senha);

    // Retorna o usuário autenticado com os dados do Supabase
    return Usuario(
      id: session.user.id, // ID do usuário retornado pelo Supabase
      nome:
          session.user.userMetadata?['nome_completo'] ??
          'Usuário', // Nome do usuário (se disponível)
      email: session.user.email ?? email, // Email do usuário
      token: session.accessToken, // Token de acesso
    );
  }

  @override
  Future<Usuario> signUp(String nome, String email, String senha) async {
    final user = await _authService.signUp(nome, email, senha);

    // Retorna o usuário recém-criado com os dados do Supabase
    return Usuario(
      id: user.id, // ID do usuário retornado pelo Supabase
      nome: nome, // Nome do usuário
      email: email, // Email do usuário
      token: null, // O token será gerado após o login
    );
  }

  @override
  Future<void> logout() async {
    await _authService.logout();
  }

  @override
  Future<bool> isLoggedIn() async {
    return await _authService.isLoggedIn();
  }
}
