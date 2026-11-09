import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/theme/app_spacing.dart';
import 'package:flutter_boilerplate/core/theme/app_typography.dart';
import 'package:flutter_boilerplate/utils/locale/app_localization.dart';

/// Predefined empty state types with appropriate icons and default messages.
enum EmptyStateType {
  connections,
  sessions,
  messages,
  skills,
  agents,
  search,
  chat,
  error,
  generic,
}

/// A premium empty state widget with illustration, title, description, and action.
/// Designed for AI app experience with clear visual hierarchy.
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? description;
  final String? actionLabel;
  final VoidCallback? onAction;
  final String? secondaryActionLabel;
  final VoidCallback? onSecondaryAction;
  final Widget? illustration;
  final double iconSize;
  final Color? iconColor;

  // For fromType factory - store type for lazy resolution
  final EmptyStateType? _type;
  final String? _customTitle;
  final String? _customDescription;
  final String? _customActionLabel;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.description,
    this.actionLabel,
    this.onAction,
    this.secondaryActionLabel,
    this.onSecondaryAction,
    this.illustration,
    this.iconSize = AppSpacing.iconIllustration,
    this.iconColor,
  }) : _type = null,
       _customTitle = null,
       _customDescription = null,
       _customActionLabel = null;

  // Private constructor for fromType
  const EmptyState._fromType({
    super.key,
    required this.icon,
    required this._type,
    this._customTitle,
    this._customDescription,
    this._customActionLabel,
    this.onAction,
    this.secondaryActionLabel,
    this.onSecondaryAction,
    this.illustration,
    required this.iconSize,
    required this.iconColor,
  }) : title = '', // Placeholder, resolved in build
       description = null, // Placeholder, resolved in build
       actionLabel = null; // Placeholder, resolved in build

  /// Creates an empty state from a predefined type.
  factory EmptyState.fromType({
    Key? key,
    required EmptyStateType type,
    String? customTitle,
    String? customDescription,
    String? actionLabel,
    VoidCallback? onAction,
    String? secondaryActionLabel,
    VoidCallback? onSecondaryAction,
    Widget? illustration,
    double iconSize = AppSpacing.iconIllustration,
  }) {
    final config = _getEmptyStateConfig(type);
    return EmptyState._fromType(
      key: key,
      icon: config.icon,
      type: type,
      customTitle: customTitle,
      customDescription: customDescription,
      customActionLabel: actionLabel,
      onAction: onAction,
      secondaryActionLabel: secondaryActionLabel,
      onSecondaryAction: onSecondaryAction,
      illustration: illustration,
      iconSize: iconSize,
      iconColor: config.color,
    );
  }

  static _EmptyStateConfig _getEmptyStateConfig(EmptyStateType type) {
    switch (type) {
      case EmptyStateType.connections:
        return const _EmptyStateConfig(
          icon: Icons.power_off_rounded,
          titleKey: 'empty_no_connections',
          titleFallback: 'No Connections',
          descriptionKey: 'empty_no_connections_desc',
          descriptionFallback: 'Connect your accounts to get started',
          actionKey: 'add_connection_title',
          actionFallback: 'Add Connection',
          color: null, // Uses colorScheme.primary
        );
      case EmptyStateType.sessions:
        return const _EmptyStateConfig(
          icon: Icons.chat_bubble_outline_rounded,
          titleKey: 'empty_no_sessions',
          titleFallback: 'No Sessions',
          descriptionKey: 'empty_no_sessions_desc',
          descriptionFallback: 'Start a new session to begin',
          actionKey: 'session_new',
          actionFallback: 'New Session',
          color: null, // Uses colorScheme.primary
        );
      case EmptyStateType.messages:
        return const _EmptyStateConfig(
          icon: Icons.forum_outlined,
          titleKey: 'empty_no_messages',
          titleFallback: 'No Messages',
          descriptionKey: 'empty_no_messages_desc',
          descriptionFallback: 'Messages will appear here',
          actionKey: null,
          actionFallback: null,
          color: null, // Uses colorScheme.primary
        );
      case EmptyStateType.skills:
        return const _EmptyStateConfig(
          icon: Icons.extension_outlined,
          titleKey: 'empty_no_skills',
          titleFallback: 'No Skills',
          descriptionKey: 'empty_no_skills_desc',
          descriptionFallback: 'Skills extend agent capabilities',
          actionKey: null,
          actionFallback: null,
          color: null, // Uses colorScheme.primary
        );
      case EmptyStateType.agents:
        return const _EmptyStateConfig(
          icon: Icons.smart_toy_outlined,
          titleKey: 'empty_no_agents',
          titleFallback: 'No Agents',
          descriptionKey: 'empty_no_agents_desc',
          descriptionFallback: 'Create your first AI agent',
          actionKey: 'agent_create',
          actionFallback: 'Create Agent',
          color: null, // Uses colorScheme.primary
        );
      case EmptyStateType.search:
        return const _EmptyStateConfig(
          icon: Icons.search_off_rounded,
          titleKey: 'empty_no_results',
          titleFallback: 'No Results',
          descriptionKey: 'empty_no_results_desc',
          descriptionFallback: 'Try a different search term',
          actionKey: null,
          actionFallback: null,
          color: null, // Uses colorScheme.primary
        );
      case EmptyStateType.chat:
        return const _EmptyStateConfig(
          icon: Icons.smart_toy_outlined,
          titleKey: 'empty_start_conversation',
          titleFallback: 'Start a Conversation',
          descriptionKey: 'empty_start_conversation_desc',
          descriptionFallback: 'Begin chatting with your AI agent',
          actionKey: null,
          actionFallback: null,
          color: null, // Uses colorScheme.primary
        );
      case EmptyStateType.error:
        return const _EmptyStateConfig(
          icon: Icons.error_outline_rounded,
          titleKey: 'empty_error',
          titleFallback: 'Something Went Wrong',
          descriptionKey: 'empty_error_desc',
          descriptionFallback: 'An error occurred. Please try again.',
          actionKey: 'retry',
          actionFallback: 'Retry',
          color: null, // Uses colorScheme.error (resolved in build)
        );
      case EmptyStateType.generic:
        return const _EmptyStateConfig(
          icon: Icons.inbox_outlined,
          titleKey: 'empty_generic',
          titleFallback: 'Nothing Here',
          descriptionKey: 'empty_generic_desc',
          descriptionFallback: "There's nothing to show right now",
          actionKey: null,
          actionFallback: null,
          color: null, // Uses colorScheme.primary
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final localizations = AppLocalizations.of(context);
    final defaultIconColor =
        iconColor ??
        (_type == EmptyStateType.error
            ? colorScheme.error
            : colorScheme.primary);

    // Resolve translations for fromType factory
    final config = _type != null ? _getEmptyStateConfig(_type) : null;
    final resolvedTitle = _type != null
        ? (_customTitle ??
              localizations?.translate(config!.titleKey) ??
              config!.titleFallback ??
              '')
        : title;
    final resolvedDescription = _type != null
        ? (_customDescription ??
              localizations?.translate(config!.descriptionKey) ??
              config!.descriptionFallback)
        : description;
    final resolvedActionLabel = _type != null
        ? (_customActionLabel ??
              (config!.actionKey != null
                  ? localizations?.translate(config.actionKey!) ??
                        config.actionFallback
                  : null))
        : actionLabel;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.space8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration or Icon
            if (illustration != null)
              illustration!
            else
              Container(
                width: iconSize + 48,
                height: iconSize + 48,
                decoration: BoxDecoration(
                  color: defaultIconColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(icon, size: iconSize, color: defaultIconColor),
                ),
              ),

            const SizedBox(height: AppSpacing.space6),

            // Title
            Text(
              resolvedTitle,
              style: AppTypography.headlineSmall(colorScheme.onSurface),
              textAlign: TextAlign.center,
            ),

            // Description
            if (resolvedDescription != null) ...[
              const SizedBox(height: AppSpacing.space2),
              Text(
                resolvedDescription,
                style: AppTypography.bodyMedium(colorScheme.onSurfaceVariant),
                textAlign: TextAlign.center,
                maxLines: 3,
              ),
            ],

            // Actions
            if (resolvedActionLabel != null && onAction != null) ...[
              const SizedBox(height: AppSpacing.space6),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onAction,
                  child: Text(resolvedActionLabel),
                ),
              ),
            ],

            if (secondaryActionLabel != null && onSecondaryAction != null) ...[
              const SizedBox(height: AppSpacing.space3),
              TextButton(
                onPressed: onSecondaryAction,
                child: Text(secondaryActionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Configuration for predefined empty states.
class _EmptyStateConfig {
  final IconData icon;
  final String titleKey;
  final String? titleFallback;
  final String descriptionKey;
  final String? descriptionFallback;
  final String? actionKey;
  final String? actionFallback;
  final Color? color;

  const _EmptyStateConfig({
    required this.icon,
    required this.titleKey,
    this.titleFallback,
    required this.descriptionKey,
    this.descriptionFallback,
    this.actionKey,
    this.actionFallback,
    this.color,
  });
}

/// A specialized empty state for onboarding/welcome screens.
class WelcomeEmptyState extends StatelessWidget {
  final String title;
  final String description;
  final Widget? illustration;
  final String primaryActionLabel;
  final VoidCallback onPrimaryAction;
  final String? secondaryActionLabel;
  final VoidCallback? onSecondaryAction;

  const WelcomeEmptyState({
    super.key,
    required this.title,
    required this.description,
    this.illustration,
    required this.primaryActionLabel,
    required this.onPrimaryAction,
    this.secondaryActionLabel,
    this.onSecondaryAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration
            if (illustration != null)
              illustration!
            else
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colorScheme.primary, colorScheme.primaryContainer],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.smart_toy_rounded,
                    size: 72,
                    color: Colors.white,
                  ),
                ),
              ),

            const SizedBox(height: AppSpacing.space8),

            // Title
            Text(
              title,
              style: AppTypography.displaySmall(colorScheme.onSurface),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.space3),

            // Description
            Text(
              description,
              style: AppTypography.bodyLarge(colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
              maxLines: 3,
            ),

            const SizedBox(height: AppSpacing.space8),

            // Primary Action
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onPrimaryAction,
                child: Text(primaryActionLabel),
              ),
            ),

            // Secondary Action
            if (secondaryActionLabel != null && onSecondaryAction != null) ...[
              const SizedBox(height: AppSpacing.space3),
              TextButton(
                onPressed: onSecondaryAction,
                child: Text(secondaryActionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
