import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter_boilerplate/di/service_locator.dart';
import 'package:flutter_boilerplate/data/local/database/daos/example_dao.dart';
import 'package:flutter_boilerplate/data/local/database/app_database.dart';

part 'example_items_provider.g.dart';

@riverpod
Stream<List<ExampleItem>> exampleItems(ExampleItemsRef ref) {
  final dao = ServiceLocator.getIt<ExampleDao>();
  return dao.watchAllItems();
}

class ExampleItemsService {
  final ExampleDao _dao;

  ExampleItemsService(this._dao);

  Future<void> addItem(String title, String? description) async {
    await _dao.insertItem(
      ExampleItemsCompanion.insert(
        id: const Uuid().v4(),
        title: title,
        description: Value(description),
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> updateItem(String id, String title, String? description) async {
    await _dao.updateItem(
      ExampleItemsCompanion(
        id: Value(id),
        title: Value(title),
        description: Value(description),
      ),
    );
  }

  Future<void> deleteItem(String id) async {
    await _dao.deleteItem(id);
  }
}
