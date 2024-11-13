import 'package:get_it/get_it.dart';
import 'package:craftshop2/features/authencation/controllers/connect_api/api_service.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => API_Services());
}
