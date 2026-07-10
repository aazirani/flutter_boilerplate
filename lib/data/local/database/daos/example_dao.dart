import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/example_table.dart';

part 'example_dao.g.dart';

@DriftAccessor(tables: [ExampleItems])
class ExampleDao extends DatabaseAccessor<AppDatabase> with _$ExampleDaoMixin {
  ExampleDao(super.db);

  Future<List<ExampleItem>> getAllItems() => select(exampleItems).get();

  Stream<List<ExampleItem>> watchAllItems() => select(exampleItems).watch();

  Future<ExampleItem> getItemById(String id) =>
      (select(exampleItems)..where((t) => t.id.equals(id))).getSingle();

  Future<void> insertItem(ExampleItemsCompanion item) =>
      into(exampleItems).insert(item);

  Future<void> updateItem(ExampleItemsCompanion item) => (update(
    exampleItems,
  )..where((t) => t.id.equals(item.id.value))).write(item);

  Future<void> deleteItem(String id) =>
      (delete(exampleItems)..where((t) => t.id.equals(id))).go();
}
