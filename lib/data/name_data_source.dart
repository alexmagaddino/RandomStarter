import 'dart:convert';
import 'dart:io';

abstract interface class NameDataSource {
  Future<List<String>> getNames();
}

class NameDataSourceImpl implements NameDataSource {
  @override
  Future<List<String>> getNames() async {
    final envVars = Platform.environment;
    final home = envVars['HOME'];

    final names = await File('$home/.random_starter/names.json').readAsString();
    final array = await json.decode(names);
    return (array as List).map((e) => e as String).toList();
  }
}
