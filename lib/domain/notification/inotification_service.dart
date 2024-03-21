abstract interface class INotificationService {
  Future<void> init();
  Future localNotificationsInit();
  Future<void> showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  });
}
