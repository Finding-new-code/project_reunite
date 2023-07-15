import 'package:get_it/get_it.dart';
import 'package:project_reunite/Apis/webrtc.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<Signalling>(() => Signalling());
  // getIt.registerLazySingleton<auth>(() => auth());
}
