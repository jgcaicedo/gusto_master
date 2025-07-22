import 'package:flutter/material.dart';
import 'package:gusto_master/core/utils/responsive.dart';

/// Widget que muestra un mensaje de error con ícono y texto.
class CustomErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  const CustomErrorWidget({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, color: colorScheme.error, size: responsive.isMobile ? 48 : 64),
          SizedBox(height: responsive.hp(2)),
          Text(
            message,
            style: textTheme.titleMedium?.copyWith(color: colorScheme.error),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            SizedBox(height: responsive.hp(2)),
            ElevatedButton(
              onPressed: onRetry,
              child: Text('Reintentar', style: textTheme.labelLarge),
            ),
          ],
        ],
      ),
    );
  }
}
