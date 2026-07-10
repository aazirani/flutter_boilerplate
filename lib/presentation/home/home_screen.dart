import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:flutter_boilerplate/core/widgets/states/states.dart';
import 'package:flutter_boilerplate/di/service_locator.dart';
import 'package:flutter_boilerplate/data/local/database/daos/example_dao.dart';
import 'package:flutter_boilerplate/presentation/providers/example_items_provider.dart';
import 'package:flutter_boilerplate/utils/locale/app_localization.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final ExampleItemsService _service;

  @override
  void initState() {
    super.initState();
    final dao = ServiceLocator.getIt<ExampleDao>();
    _service = ExampleItemsService(dao);
  }

  String _tr(String key, [String fallback = '']) =>
      AppLocalizations.of(context)?.translate(key) ?? fallback;

  Future<void> _showItemDialog({
    String? id,
    String? title,
    String? description,
  }) async {
    final isEditing = id != null;
    final titleController = TextEditingController(text: title ?? '');
    final descController = TextEditingController(text: description ?? '');

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          isEditing ? _tr('edit', 'Edit') : _tr('add_item', 'Add Item'),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: _tr('item_title', 'Title'),
                hintText: _tr('enter_title', 'Enter title'),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descController,
              decoration: InputDecoration(
                labelText: _tr('item_description', 'Description'),
                hintText: _tr('enter_description', 'Enter description'),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(_tr('cancel', 'Cancel')),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(_tr('save', 'Save')),
          ),
        ],
      ),
    );

    if (result == true && titleController.text.trim().isNotEmpty) {
      if (isEditing) {
        await _service.updateItem(
          id,
          titleController.text.trim(),
          descController.text.trim().isEmpty
              ? null
              : descController.text.trim(),
        );
      } else {
        await _service.addItem(
          titleController.text.trim(),
          descController.text.trim().isEmpty
              ? null
              : descController.text.trim(),
        );
      }
    }
    titleController.dispose();
    descController.dispose();
  }

  Future<void> _confirmDelete(String id, String title) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_tr('delete', 'Delete')),
        content: Text(
          _tr('confirm_delete', 'Are you sure you want to delete "$title"?'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(_tr('cancel', 'Cancel')),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(_tr('delete', 'Delete')),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _service.deleteItem(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final itemsAsync = ref.watch(exampleItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_tr('home', 'Home')),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.go('/settings'),
          ),
        ],
      ),
      body: itemsAsync.when(
        loading: () => const LoadingState(),
        error: (error, stack) => ErrorState(
          message: error.toString(),
          onRetry: () => ref.invalidate(exampleItemsProvider),
        ),
        data: (items) {
          if (items.isEmpty) {
            return EmptyState(
              icon: Icons.inbox_outlined,
              title: _tr('no_items', 'No items yet'),
              description: _tr(
                'welcome_message',
                'Tap the + button to add one!',
              ),
              actionLabel: _tr('add_item', 'Add Item'),
              onAction: () => _showItemDialog(),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final dateStr = DateFormat.yMMMd().format(item.createdAt);

              return Dismissible(
                key: Key(item.id),
                direction: DismissDirection.endToStart,
                confirmDismiss: (_) async {
                  await _confirmDelete(item.id, item.title);
                  return false; // we handle deletion ourselves
                },
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  color: theme.colorScheme.error,
                  child: Icon(Icons.delete, color: theme.colorScheme.onError),
                ),
                child: Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: ListTile(
                    title: Text(
                      item.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (item.description != null &&
                            item.description!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              item.description!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            dateStr,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.outline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    isThreeLine:
                        item.description != null &&
                        item.description!.isNotEmpty,
                    onTap: () => _showItemDialog(
                      id: item.id,
                      title: item.title,
                      description: item.description,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showItemDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
