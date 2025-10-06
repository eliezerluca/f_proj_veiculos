# Guia de arquivos (autenticação)

Este arquivo explica rapidamente o propósito de cada arquivo/folder relacionado à autenticação no projeto.

## Estrutura principal

- `lib/domain/models/usuario.dart`
  - Modelo de domínio que representa o usuário dentro da aplicação.

- `lib/domain/repositories/auth_repository.dart`
  - Interface que define o contrato de autenticação usado pela aplicação.

- `lib/data/services/auth_service.dart`
  - Camada que fala com o Supabase. Contém `signUp`, `login`, `logout`.

- `lib/data/repositories/auth_repository_impl.dart`
  - Implementação do repositório que usa `AuthService` para devolver `Usuario`.

- `lib/validators/auth/login_validator.dart`
  - Regras de validação para o formulário de login (email, senha).

- `lib/validators/auth/signup_validator.dart`
  - Regras de validação para o formulário de cadastro (nome, email, senha).

- `lib/ui/controllers/auth_controller.dart`
  - Controlador que gerencia estado de autenticação (ValueNotifier<AuthState>), chama o repositório e lida com erros.

- `lib/ui/widgets/auth_wrapper.dart`
  - Wrapper que decide qual tela exibir com base no estado de autenticação (Login ou Home).

- `lib/ui/screens/auth/sign_in.dart`
  - Tela de login com formulários e integração com validators e controller.

- `lib/ui/screens/auth/sign_up.dart`
  - Tela de cadastro com formulários, validações e integração com controller.

- `lib/ui/screens/home/home.dart`
  - Tela principal que aparece após autenticação, com botão para logout.

- `lib/main.dart`
  - Ponto de entrada do app. Inicializa Supabase e usa `AuthWrapper` como root.

---

### Observações
- Os arquivos são organizados por responsabilidade: `domain` (contratos e modelos), `data` (implementações e serviços), `ui` (telas e controllers), `validators` (regras de validação). Isso facilita manutenção e testes.
- Caso queira rodar testes unitários, foque em `auth_service.dart` (integração), `auth_repository_impl.dart` (lógica de transformação) e nos validators (regras).