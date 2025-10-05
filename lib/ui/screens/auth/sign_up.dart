import 'package:flutter/material.dart';
import 'package:proj_veiculos/data/repositories/auth_repository_impl.dart';
import 'package:proj_veiculos/data/services/auth_service.dart';
import 'package:proj_veiculos/ui/controllers/auth_controller.dart';
import 'package:proj_veiculos/ui/screens/auth/sign_in.dart';
import 'package:proj_veiculos/ui/screens/home/home.dart';
import 'package:proj_veiculos/ui/validators/auth/signup_validator.dart';
import 'package:proj_veiculos/ui/core/themes/app_theme.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final validator = SignUpValidator();
  final signUpModel = SignUpModel();

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
    switch (authController.value) {
      case AuthState.authenticated:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
        break;
      case AuthState.error:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authController.errorMessage ?? 'Erro desconhecido'),
            backgroundColor: Colors.red,
          ),
        );
        break;
      default:
        break;
    }
  }

  void _updateModel() {
    signUpModel.name = nomeController.text;
    signUpModel.email = emailController.text;
    signUpModel.password = senhaController.text;
  }

  Future<void> _handleSignUp() async {
    _updateModel();
    if (_formKey.currentState?.validate() ?? false) {
      await authController.signUp(
        signUpModel.name,
        signUpModel.email,
        signUpModel.password,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network('https://placehold.co/250x100.png'),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Criar Conta',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppTheme.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  _updateModel();
                  return validator.byField(signUpModel, 'name').call(value);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  _updateModel();
                  return validator.byField(signUpModel, 'email').call(value);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: senhaController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  helperText:
                      'Mín. 6 caracteres, com maiúscula, minúscula e número',
                  helperMaxLines: 2,
                ),
                validator: (value) {
                  _updateModel();
                  return validator.byField(signUpModel, 'password').call(value);
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ValueListenableBuilder<AuthState>(
                  valueListenable: authController,
                  builder: (context, state, child) {
                    return ElevatedButton(
                      onPressed: state == AuthState.loading
                          ? null
                          : _handleSignUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.secondaryColor,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: state == AuthState.loading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Cadastrar'),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignIn(),
                    ),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Já tem uma conta? ',
                    style: TextStyle(color: AppTheme.lightTextColor),
                    children: [
                      TextSpan(
                        text: 'Faça login',
                        style: TextStyle(color: AppTheme.secondaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
