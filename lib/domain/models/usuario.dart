import 'package:freezed_annotation/freezed_annotation.dart';

part 'usuario.freezed.dart'; // Arquivo gerado pelo Freezed
part 'usuario.g.dart'; // Arquivo gerado para serialização JSON

@freezed
class Usuario with _$Usuario {
  const factory Usuario({
    required String id,
    required String nome,
    required String email,
    String? token,
  }) = _Usuario;

  factory Usuario.fromJson(Map<String, Object?> json) =>
      _$UsuarioFromJson(json);
}
