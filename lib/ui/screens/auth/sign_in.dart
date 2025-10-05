import 'package:flutter/material.dart';
import 'package:proj_veiculos/data/repositories/auth_repository_impl.dart';
import 'package:proj_veiculos/data/services/auth_service.dart';
import 'package:proj_veiculos/ui/controllers/auth_controller.dart';
import 'package:proj_veiculos/ui/screens/auth/sign_up.dart';
import 'package:proj_veiculos/ui/screens/home/home.dart';
import 'package:proj_veiculos/ui/validators/auth/login_validator.dart';
import '../../core/themes/app_theme.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final validator = LoginValidator();
  final loginModel = LoginModel();

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
    loginModel.email = emailController.text;
    loginModel.password = senhaController.text;
  }

  Future<void> _handleLogin() async {
    _updateModel();
    if (_formKey.currentState?.validate() ?? false) {
      await authController.login(loginModel.email, loginModel.password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.lightBackgroundColor,
        // title: Container(
        //   width: 150,
        //   height: 40,
        //   decoration: const BoxDecoration(
        //     color: Colors.amber,
        //   ),
        // ),
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
                'Login',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppTheme.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
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
                  return validator.byField(loginModel, 'email').call(value);
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
                ),
                validator: (value) {
                  _updateModel();
                  return validator.byField(loginModel, 'password').call(value);
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
                          : _handleLogin,
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
                          : const Text('Fazer Login'),
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
                      builder: (context) => const SignUp(),
                    ),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Ainda não tem uma conta? ',
                    style: TextStyle(color: AppTheme.lightTextColor),
                    children: [
                      TextSpan(
                        text: 'Inscreva-se',
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
