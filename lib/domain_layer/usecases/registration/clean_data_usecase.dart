import '../../../data_layer/respositories.dart';

class CleanDataUseCase {
  final EmpregoRepository _empregosRepository;

  const CleanDataUseCase({
    required EmpregoRepository empregoRepository,
  }) : _empregosRepository = empregoRepository;

  Future<void> call() async {
    Future.delayed(
      Duration(milliseconds: 400),
      () => _empregosRepository.cleanAll(),
    );
  }
}
