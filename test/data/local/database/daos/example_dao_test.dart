import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart' hide isNull;
import 'package:flutter_boilerplate/data/local/database/app_database.dart';
import 'package:flutter_boilerplate/data/local/database/daos/example_dao.dart';
import 'package:drift/native.dart';

void main() {
  group('ExampleDao', () {
    late AppDatabase db;
    late ExampleDao dao;

    setUp(() {
      db = AppDatabase.forTesting(NativeDatabase.memory());
      dao = ExampleDao(db);
    });

    tearDown(() async {
      await db.close();
    });

    test('insertItem adds item and getAllItems returns it', () async {
      final now = DateTime.now();
      final normalizedNow = DateTime.fromMillisecondsSinceEpoch(
        now.millisecondsSinceEpoch,
      );
      await dao.insertItem(
        ExampleItemsCompanion.insert(
          id: 'test-1',
          title: 'Test Title',
          description: const Value('Test Description'),
          createdAt: normalizedNow,
        ),
      );

      final items = await dao.getAllItems();
      expect(items, hasLength(1));
      expect(items.first.id, 'test-1');
      expect(items.first.title, 'Test Title');
      expect(items.first.description, 'Test Description');
      // DateTime storage may truncate milliseconds; verify close enough
      expect(items.first.createdAt, isA<DateTime>());
      expect(
        items.first.createdAt.difference(normalizedNow).inSeconds.abs(),
        lessThanOrEqualTo(1),
      );
    });

    test('insertItem without description works', () async {
      await dao.insertItem(
        ExampleItemsCompanion.insert(
          id: 'test-2',
          title: 'No Desc',
          createdAt: DateTime.now(),
        ),
      );

      final items = await dao.getAllItems();
      expect(items, hasLength(1));
      expect(items.first.description, null);
    });

    test('watchAllItems emits after insert', () async {
      final stream = dao.watchAllItems();

      // Listen to stream and capture emissions
      final emitted = <List<ExampleItem>>[];
      final subscription = stream.listen((items) {
        emitted.add(items);
      });

      // Wait for first emission (empty list initially)
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Insert an item
      await dao.insertItem(
        ExampleItemsCompanion.insert(
          id: 'test-3',
          title: 'Stream Test',
          createdAt: DateTime.now(),
        ),
      );

      // Wait for stream to emit
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Cancel subscription and verify
      await subscription.cancel();

      expect(emitted, isNotEmpty);
      // Last emission should contain the inserted item
      final lastEmission = emitted.last;
      final matchingItems = lastEmission.where((item) => item.id == 'test-3');
      expect(matchingItems, hasLength(1));
      expect(matchingItems.first.title, 'Stream Test');
    });

    test('getItemById returns correct item', () async {
      await dao.insertItem(
        ExampleItemsCompanion.insert(
          id: 'item-a',
          title: 'A',
          createdAt: DateTime.now(),
        ),
      );
      await dao.insertItem(
        ExampleItemsCompanion.insert(
          id: 'item-b',
          title: 'B',
          createdAt: DateTime.now(),
        ),
      );

      final item = await dao.getItemById('item-a');
      expect(item.id, 'item-a');
      expect(item.title, 'A');
    });

    test('getItemById throws when not found', () async {
      expect(() => dao.getItemById('nonexistent'), throwsA(isA<StateError>()));
    });

    test('updateItem changes title', () async {
      await dao.insertItem(
        ExampleItemsCompanion.insert(
          id: 'update-me',
          title: 'Original',
          createdAt: DateTime.now(),
        ),
      );

      await dao.updateItem(
        const ExampleItemsCompanion(
          id: Value('update-me'),
          title: Value('Updated'),
        ),
      );

      final item = await dao.getItemById('update-me');
      expect(item.title, 'Updated');
    });

    test('deleteItem removes item', () async {
      await dao.insertItem(
        ExampleItemsCompanion.insert(
          id: 'delete-me',
          title: 'Delete Me',
          createdAt: DateTime.now(),
        ),
      );

      // Verify it exists
      var items = await dao.getAllItems();
      expect(items, hasLength(1));

      await dao.deleteItem('delete-me');

      // Verify it's gone
      items = await dao.getAllItems();
      expect(items, isEmpty);
    });

    test('multiple inserts and getAllItems returns all', () async {
      await dao.insertItem(
        ExampleItemsCompanion.insert(
          id: 'item-1',
          title: 'First',
          createdAt: DateTime.now(),
        ),
      );
      await dao.insertItem(
        ExampleItemsCompanion.insert(
          id: 'item-2',
          title: 'Second',
          createdAt: DateTime.now(),
        ),
      );
      await dao.insertItem(
        ExampleItemsCompanion.insert(
          id: 'item-3',
          title: 'Third',
          createdAt: DateTime.now(),
        ),
      );

      final items = await dao.getAllItems();
      expect(items, hasLength(3));
    });
  });
}
