import 'package:get_it/get_it.dart';
import 'package:random_starter/data/name_data_source.dart';
import 'package:random_starter/data/name_repository_impl.dart';
import 'package:random_starter/domain/get_names_use_case.dart';
import 'package:random_starter/domain/name_repository.dart';
import 'package:random_starter/presentation/fortune_wheel_cubit.dart';

final injector = GetIt.instance;

void injectorSetUp() {
  // DataSources
  injector.registerLazySingleton<NameDataSource>(() => NameDataSourceImpl());

  // Repositories
  injector.registerLazySingleton<NameRepository>(
    () => NameRepositoryImpl(injector.get()),
  );

  // UseCases
  injector.registerLazySingleton(() => GetNamesUseCase(injector.get()));

  // Cubits
  injector.registerFactory(() => FortuneWheelCubit(injector.get()));
}
