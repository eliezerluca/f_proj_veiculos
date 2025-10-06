# Testes e verificação do fluxo de autenticação

Este documento dá passos práticos para validar o fluxo de autenticação implementado no app.

## 1) Teste de cadastro (Sign Up)
- Abra o app
- Clique em "Inscreva-se"
- Preencha os campos corretamente
  - Nome: mínimo 2 caracteres
  - Email: formato válido
  - Senha: mínimo 6 caracteres, com maiúscula, minúscula e número
- Clique em "Cadastrar"
- Se a confirmação de email estiver habilitada, confirme no painel do Supabase ou via link recebido por email
- Ao final, o app deve navegar para `Home`

## 2) Teste de login (Sign In)
- Abra o app
- Insira email e senha válidos
- Clique em "Fazer Login"
- O app deve navegar para `Home`

## 3) Teste de logout
- Na `Home`, clique no ícone de logout
- O app deve voltar para a tela de `SignIn`

## 4) Teste de validações
- Tente submeter o formulário com dados inválidos (email sem `@`, senha curta, etc.)
- Verifique se as mensagens de validação aparecem corretamente (regras definidas em `lib/validators/auth`)

## 5) Teste de sessão persistente
- Faça login
- Feche o app e reabra
- O `AuthWrapper` deve verificar o estado e manter o usuário na `Home` (se a sessão do Supabase persistir)

## 6) Logs e erros
- Em caso de erros, verifique os logs do Flutter no terminal (onde executou `flutter run`)
- Mensagens de erro do Supabase são repassadas através do `AuthController` e exibidas via `SnackBar`

---

Se quiser, posso também gerar testes unitários básicos para o `LoginValidator` e `SignUpValidator`.