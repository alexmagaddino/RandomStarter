import 'package:random_starter/common/result.dart';

abstract interface class NameRepository {
  Future<Result<List<String>>> getNames();
}
