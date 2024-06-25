import 'package:sapdos/features/data/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository authRepository;

  RegisterUseCase(this.authRepository);

  Future<bool> execute(String email, String password) async {
    return await authRepository.register(email, password);
  }
}
