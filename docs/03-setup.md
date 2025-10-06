# Setup e execução local (autenticação)

Este guia mostra como configurar o projeto localmente, incluindo as configurações necessárias no Supabase.

## Requisitos
- Flutter instalado (recomendado Flutter 3.7+)
- Conta no Supabase e projeto criado
- `flutter pub get` executado

## 1) Dependências
No `pubspec.yaml` o projeto já contém:
- `supabase_flutter`
- `lucid_validation`
- `google_fonts`

Execute:

```bash
flutter pub get
```

## 2) Configurar Supabase
No painel do Supabase:
1. Vá em **Settings → API** e copie:
   - `Project URL` (ex.: `https://<project-id>.supabase.co`)
   - `anon key`
2. Cole esses valores em `lib/main.dart` dentro de `Supabase.initialize(...)`

### 3) Confirmação de email
Se quiser testar com confirmação de email habilitada (recomendado para reproduzir fluxo real):
- Vá em **Authentication → Settings**
- Deixe **Enable email confirmations** ativado
- Defina **Site URL** e **Redirect URLs** para uma URL de testes (ex.: `http://localhost:3000`) ou configure deep links no app.

> Dica: para desenvolvimento, você pode confirmar manualmente o usuário em **Authentication → Users** clicando em "Confirm user".

## 4) Executar o app
Execute no terminal:

```bash
flutter run
```

## 5) Testes rápidos
- Crie uma conta no app (Sign Up) — se o e-mail exigir confirmação, confirme-o via painel do Supabase ou por link
- Faça login — deve navegar automaticamente para a `Home`
- Use o botão de logout em `Home` para desfazer a sessão

---

Se quiser que eu gere um script `env` ou um `.env_example` para gerenciar as chaves com mais segurança (em vez de colar no `main.dart`), eu posso adicionar isso também.