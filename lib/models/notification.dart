

class PushNotification {
  PushNotification({
    required this.title,
    required this.body,
    required this.imageUrl,
  });
  String title;
  String body;
  String imageUrl;
}

List<PushNotification> notifications = [];