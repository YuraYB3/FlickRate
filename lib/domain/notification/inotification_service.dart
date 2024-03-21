abstract interface class INotificationService {
  Future<void> init();
  Future localNotificationsInit();
  Future<void> showNotification({
    required String title,
    required String body,
    required String payload,
  });
  Future<void> setNotificationsHandlers();
}
