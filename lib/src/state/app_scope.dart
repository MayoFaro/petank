import 'package:flutter/widgets.dart';

import 'app_controller.dart';

class AppScope extends InheritedNotifier<AppController> {
  const AppScope({
    super.key,
    required AppController controller,
    required Widget child,
  }) : super(notifier: controller, child: child);

  static AppController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    if (scope == null || scope.notifier == null) {
      throw StateError('AppScope introuvable dans le contexte.');
    }
    return scope.notifier!;
  }
}
