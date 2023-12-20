import 'package:random_starter/common/result.dart';
import 'package:random_starter/domain/name_repository.dart';

final class GetNamesUseCase {
  final NameRepository _repository;

  const GetNamesUseCase(this._repository);

  Future<Result<List<String>>> call() {
    return _repository.getNames();
  }
}
