import 'package:lucid_validation/lucid_validation.dart';

// Modelo para os dados de login
class LoginModel {
  String email;
  String password;

  LoginModel({this.email = '', this.password = ''});
}

// Validador personalizado para login
class LoginValidator extends LucidValidator<LoginModel> {
  LoginValidator() {
    ruleFor((login) => login.email, key: 'email').notEmpty().validEmail();

    ruleFor((login) => login.password, key: 'password').notEmpty().minLength(6);
  }
}
