# Timeline: como a autenticação foi construída

Este documento descreve, passo a passo, a ordem em que os arquivos e componentes foram criados para implementar o fluxo de autenticação (sign up / sign in / logout) neste projeto Flutter.

O objetivo é oferecer uma linha do tempo lógica: por que criamos cada peça na ordem em que foi feita, e como cada uma habilita a próxima.

---

## 1. Modelos de domínio (Domain Model)
- Arquivo: `lib/domain/models/usuario.dart`
- Por que primeiro: antes de persistir ou transmitir dados, precisamos definir a forma (contrato) dos dados que representam um usuário. Isso evita decisões de design repetidas e mantém consistência entre camadas.
- O que faz: define `Usuario` com campos como `id`, `nome`, `email` e `token`.

## 2. Serviço de autenticação (Service)
- Arquivo: `lib/data/services/auth_service.dart`
- Por que depois do modelo: o serviço depende do formato dos dados (por exemplo, os metadados do usuário enviados ao Supabase). Implementá-lo somente após o modelo garante que os retornos sejam convertidos de forma consistente.
- O que faz: encapsula chamadas ao Supabase (`signUp`, `login`, `signOut`, `currentSession`) e lança exceções padronizadas.

## 3. Repositório (Repository)
- Arquivo: `lib/data/repositories/auth_repository_impl.dart` e `lib/domain/repositories/auth_repository.dart`
- Por que depois do service: o repositório é uma abstração usada pelo domínio/controle; ele compõe o serviço e transforma suas respostas em entidades do domínio (`Usuario`).
- O que faz: implementa os métodos do contrato do repositório (`login`, `signUp`, `logout`, `isLoggedIn`) usando `AuthService`.

## 4. Validações (Validators)
- Pasta: `lib/validators/auth/`
- Arquivos: `login_validator.dart`, `signup_validator.dart`
- Por que agora: ajudar a garantir que os dados vindos da UI estejam corretos antes de chamar o repositório. Criar validators antes das telas evita repetição de regras e melhora a experiência do desenvolvedor.
- O que faz: define regras reutilizáveis usando `lucid_validation` (ex.: `validEmail`, `minLength`, `mustHaveUppercase`).

## 5. Telas (UI)
- Pasta: `lib/ui/screens/auth/`
- Arquivos: `sign_in.dart`, `sign_up.dart`
- Por que depois dos validators: as telas podem ligar diretamente os `TextFormField` aos validators. A UI também depende de componentes já prontos (por exemplo, `CustomInput` e `AppTheme`).
- O que faz: implementa a interface do usuário, formulários, integração com validators e navegação.

## 6. Controller (State management)
- Arquivo: `lib/ui/controllers/auth_controller.dart`
- Por que depois do repositório e telas: o controller orquestra a lógica de negócio (chama repositório, atualiza estado, gerencia erros) e é ligado à UI.
- O que faz: expõe métodos `login`, `signUp`, `logout`, além de um `ValueNotifier<AuthState>` que a UI observa.

## 7. Auth Wrapper (Manager de rota/estado)
- Arquivo: `lib/ui/widgets/auth_wrapper.dart`
- Por que depois do controller: precisa do controller para checar o estado inicial (logado/não logado) e renderizar a tela correta (SignIn ou Home).
- O que faz: componente que escolhe a tela inicial do app baseado no estado de autenticação.

## 8. Home (pós-login)
- Arquivo: `lib/ui/screens/home/home.dart`
- Por que por último: representa a área autenticada do app; depende do controller para logout e do wrapper para navegação.
- O que faz: mostra conteúdo após login e oferece botão de logout.

---

### Observações finais
- Esta ordem reduz acoplamento e facilita testes: modelos → serviços → repositórios → validações → UI → controllers → navegação.
- Em projetos maiores, você pode criar os "contratos" (interfaces) primeiro e fazer implementações paralelas, mas a linha acima reflete uma ordem pragmática seguida neste projeto.
