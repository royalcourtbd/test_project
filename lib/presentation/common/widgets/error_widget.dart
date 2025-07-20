import 'package:flutter/material.dart';
import 'package:initial_project/presentation/common/widgets/custom_error_widget.dart';

class ErrorWidgetClass extends StatelessWidget {
  const ErrorWidgetClass({super.key, required this.errorDetails});

  final FlutterErrorDetails errorDetails;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Error',
      home: CustomErrorWidget(errorDetails: errorDetails),
    );
  }
}
