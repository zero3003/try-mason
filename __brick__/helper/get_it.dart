import 'package:get_it/get_it.dart';
import 'package:sim_jalan_mobile/feature/dimensi/repository/dimensi_repository.dart';
import 'package:sim_jalan_mobile/feature/kondisi/repository/kondisi_repository.dart';

import '../feature/kondisi/repository/ref_kondisi_repository.dart';

GetIt getIt = GetIt.instance;

registerLocator() {
  getIt.registerLazySingleton(() => DimensiRepository());
  getIt.registerLazySingleton(() => KondisiRepository());
  getIt.registerLazySingleton(() => RefKondisiRepository());
}
