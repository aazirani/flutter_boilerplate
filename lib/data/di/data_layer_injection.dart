import 'package:flutter_boilerplate/data/local/database/app_database.dart';
import 'package:flutter_boilerplate/data/local/database/daos/example_dao.dart';
import 'package:flutter_boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter_boilerplate/di/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataLayerInjection {
  static Future<void> configureDataLayerInjection() async {
    ServiceLocator.getIt.registerSingletonAsync<SharedPreferences>(
      SharedPreferences.getInstance,
    );
    ServiceLocator.getIt.registerSingleton<SharedPreferenceHelper>(
      SharedPreferenceHelper(
        await ServiceLocator.getIt.getAsync<SharedPreferences>(),
      ),
    );

    ServiceLocator.getIt.registerSingletonAsync<AppDatabase>(
      () async => AppDatabase(),
    );

    ServiceLocator.getIt.registerSingletonWithDependencies<ExampleDao>(
      () => ExampleDao(ServiceLocator.getIt<AppDatabase>()),
      dependsOn: [AppDatabase],
    );

    await ServiceLocator.getIt.allReady();
  }
}
