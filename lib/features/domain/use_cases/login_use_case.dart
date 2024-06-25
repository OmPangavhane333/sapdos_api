import 'package:sapdos/features/data/repositories/auth_repository.dart';


class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<bool> execute(String email, String password) async {
    return await authRepository.login(email, password);
  }
}
