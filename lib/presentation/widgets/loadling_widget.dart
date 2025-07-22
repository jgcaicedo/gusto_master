import 'package:flutter/material.dart';
import 'package:gusto_master/core/utils/responsive.dart';

/// Widget que muestra un indicador de carga circular.
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Center(
      child: SizedBox(
        width: responsive.isMobile ? 48 : 64,
        height: responsive.isMobile ? 48 : 64,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
