import 'package:lucid_validation/lucid_validation.dart';

// Modelo para os dados de cadastro
class SignUpModel {
  String name;
  String email;
  String password;

  SignUpModel({this.name = '', this.email = '', this.password = ''});
}

// Validador personalizado para cadastro
class SignUpValidator extends LucidValidator<SignUpModel> {
  SignUpValidator() {
    ruleFor((signup) => signup.name, key: 'name').notEmpty().minLength(2);

    ruleFor((signup) => signup.email, key: 'email').notEmpty().validEmail();

    ruleFor((signup) => signup.password, key: 'password')
        .notEmpty()
        .minLength(6)
        .mustHaveUppercase()
        .mustHaveLowercase()
        .mustHaveNumber();
  }
}
