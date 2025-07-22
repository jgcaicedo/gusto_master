import 'package:flutter/material.dart';
import 'package:gusto_master/core/utils/responsive.dart';

/// Widget que muestra un mensaje de error con ícono y texto.
class CustomErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  const CustomErrorWidget({Key? key, required this.message, this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, color: Colors.red, size: responsive.isMobile ? 48 : 64),
          SizedBox(height: responsive.hp(2)),
          Text(
            message,
            style: TextStyle(
              color: Colors.red,
              fontSize: responsive.isMobile ? 18 : 24,
            ),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            SizedBox(height: responsive.hp(2)),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Reintentar'),
            ),
          ],
        ],
      ),
    );
  }
}
