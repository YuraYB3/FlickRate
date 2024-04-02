import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'default_notification_view.dart';
import 'default_notification_view_model.dart';

class DefaultNotificationScreenFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) => DefaultNotificationViewModel(),
      child: Consumer<DefaultNotificationViewModel>(
        builder: (context, value, child) => const DefaultNotificationView(),
      ),
    );
  }
}
