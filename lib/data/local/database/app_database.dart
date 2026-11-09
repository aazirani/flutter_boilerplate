import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';

import 'tables/example_table.dart';

part 'app_database.drift.dart';

@DriftDatabase(tables: [ExampleItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(onCreate: (Migrator m) => m.createAll());
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'flutter_boilerplate',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.dart.js'),
        onResult: (result) {
          if (result.missingFeatures.isNotEmpty) {
            debugPrint(
              'Drift web: using ${result.chosenImplementation} '
              '(missing: ${result.missingFeatures})',
            );
          }
        },
      ),
    );
  }
}
