import 'package:flutter/material.dart';

enum CatButtonVariant { filled, outlined, text, danger }
enum CatButtonSize { small, medium, large }

class CatButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final CatButtonVariant variant;
  final CatButtonSize size;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool loading;
  final bool fullWidth;

  const CatButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = CatButtonVariant.filled,
    this.size = CatButtonSize.medium,
    this.leadingIcon,
    this.trailingIcon,
    this.loading = false,
    this.fullWidth = false,
  });

  const CatButton.filled({
    super.key,
    required this.label,
    this.onPressed,
    this.size = CatButtonSize.medium,
    this.leadingIcon,
    this.trailingIcon,
    this.loading = false,
    this.fullWidth = false,
  }) : variant = CatButtonVariant.filled;

  const CatButton.outlined({
    super.key,
    required this.label,
    this.onPressed,
    this.size = CatButtonSize.medium,
    this.leadingIcon,
    this.trailingIcon,
    this.loading = false,
    this.fullWidth = false,
  }) : variant = CatButtonVariant.outlined;

  const CatButton.text({
    super.key,
    required this.label,
    this.onPressed,
    this.size = CatButtonSize.medium,
    this.leadingIcon,
    this.trailingIcon,
    this.loading = false,
    this.fullWidth = false,
  }) : variant = CatButtonVariant.text;

  const CatButton.danger({
    super.key,
    required this.label,
    this.onPressed,
    this.size = CatButtonSize.medium,
    this.leadingIcon,
    this.trailingIcon,
    this.loading = false,
    this.fullWidth = false,
  }) : variant = CatButtonVariant.danger;

  EdgeInsets _padding() {
    switch (size) {
      case CatButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      case CatButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 10);
      case CatButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 14);
    }
  }

  double _fontSize() {
    switch (size) {
      case CatButtonSize.small:
        return 12;
      case CatButtonSize.medium:
        return 14;
      case CatButtonSize.large:
        return 16;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color bgColor;
    Color fgColor;
    BorderSide border;

    final effectiveOnPressed = loading ? null : onPressed;

    switch (variant) {
      case CatButtonVariant.filled:
        bgColor = theme.colorScheme.primary;
        fgColor = theme.colorScheme.onPrimary;
        border = BorderSide.none;
      case CatButtonVariant.outlined:
        bgColor = Colors.transparent;
        fgColor = theme.colorScheme.primary;
        border = BorderSide(color: theme.colorScheme.outline);
      case CatButtonVariant.text:
        bgColor = Colors.transparent;
        fgColor = theme.colorScheme.primary;
        border = BorderSide.none;
      case CatButtonVariant.danger:
        bgColor = theme.colorScheme.error;
        fgColor = theme.colorScheme.onError;
        border = BorderSide.none;
    }

    Widget child = Row(
      mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (loading) ...[
          SizedBox(
            width: _fontSize() + 2,
            height: _fontSize() + 2,
            child: CircularProgressIndicator(strokeWidth: 2, color: fgColor),
          ),
          const SizedBox(width: 8),
        ] else if (leadingIcon != null) ...[
          Icon(leadingIcon, size: _fontSize() + 4),
          const SizedBox(width: 6),
        ],
        Text(label, style: TextStyle(fontSize: _fontSize(), fontWeight: FontWeight.w600)),
        if (trailingIcon != null) ...[
          const SizedBox(width: 6),
          Icon(trailingIcon, size: _fontSize() + 4),
        ],
      ],
    );

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: variant == CatButtonVariant.text
          ? TextButton(
              onPressed: effectiveOnPressed,
              style: TextButton.styleFrom(
                foregroundColor: fgColor,
                padding: _padding(),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: child,
            )
          : variant == CatButtonVariant.outlined
              ? OutlinedButton(
                  onPressed: effectiveOnPressed,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: fgColor,
                    side: border,
                    padding: _padding(),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: child,
                )
              : FilledButton(
                  onPressed: effectiveOnPressed,
                  style: FilledButton.styleFrom(
                    backgroundColor: bgColor,
                    foregroundColor: fgColor,
                    padding: _padding(),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: child,
                ),
    );
  }
}