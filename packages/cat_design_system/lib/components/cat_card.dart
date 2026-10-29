import 'package:flutter/material.dart';

class CatCard extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final BorderRadius? borderRadius;
  final double elevation;
  final Widget? header;
  final Widget? footer;

  const CatCard({
    super.key,
    this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.color,
    this.borderRadius,
    this.elevation = 1,
    this.header,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget card = Card(
      color: color ?? theme.cardTheme.color,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      margin: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (header != null) ...[
                header!,
                const SizedBox(height: 12),
              ],
              if (child != null) child!,
              if (footer != null) ...[
                const SizedBox(height: 12),
                const Divider(height: 1),
                const SizedBox(height: 12),
                footer!,
              ],
            ],
          ),
        ),
      ),
    );

    return card;
  }
}