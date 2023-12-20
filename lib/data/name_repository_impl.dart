import 'package:flutter/foundation.dart';
import 'package:random_starter/common/result.dart';
import 'package:random_starter/data/name_data_source.dart';
import 'package:random_starter/domain/name_repository.dart';

class NameRepositoryImpl implements NameRepository {
  final NameDataSource _dataSource;

  const NameRepositoryImpl(this._dataSource);

  @override
  Future<Result<List<String>>> getNames() async {
    try {
      final names = await _dataSource.getNames();
      return Result.success(names);
    } on Exception catch (e, stackTrace) {
      if (kDebugMode) {
        print(e.toString());
        print(stackTrace);
      }
      return Result.error(e);
    }
  }
}
