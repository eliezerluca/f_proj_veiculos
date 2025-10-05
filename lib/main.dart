import 'package:flutter/material.dart';
import 'package:proj_veiculos/ui/core/themes/app_theme.dart';
import 'package:proj_veiculos/ui/widgets/auth_wrapper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicialize o Supabase
  await Supabase.initialize(
    url: 'https://adjnvdgrmmcchczjkydw.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFkam52ZGdybW1jY2hjempreWR3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTg2NjczMzksImV4cCI6MjA3NDI0MzMzOX0.KF8qOhT8LH3geo5JFz34L8cplagZ8XZnVe_h_BNxpt4', // Substitua pela sua chave anônima
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proj Veículos',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home:
          const AuthWrapper(), // AuthWrapper gerencia o estado de autenticação
    );
  }
}
