import 'package:flutter/material.dart';
import 'package:gusto_master/data/models/gusto.dart';
import 'package:gusto_master/core/utils/responsive.dart';

/// Widget que representa visualmente un gusto en una tarjeta.
/// Incluye imagen, nombre, apiName y acciones de eliminar y ver detalle.
class GustoCard extends StatelessWidget {
  final Gusto gusto;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;
  const GustoCard({super.key, required this.gusto, this.onDelete, this.onTap});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: responsive.isMobile ? 0 : responsive.wp(2),
        vertical: responsive.hp(0.5),
      ),
      color: colorScheme.surface,
      child: ListTile(
        leading: Image.network(
          gusto.imagenUrl,
          width: responsive.isMobile ? 40 : 56,
          height: responsive.isMobile ? 40 : 56,
          errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, size: responsive.isMobile ? 40 : 56, color: colorScheme.error),
        ),
        title: Text(gusto.nombre, style: textTheme.titleMedium),
        subtitle: Text(gusto.apiName, style: textTheme.bodyMedium),
        onTap: onTap,
        trailing: IconButton(
          icon: Icon(Icons.delete, color: colorScheme.error),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
