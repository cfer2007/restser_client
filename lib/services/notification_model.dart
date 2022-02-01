class NotificationModel{
  String? uid;
  String? title;
  String? message;
  Map<String,String>? data;

  NotificationModel({
    this.uid,
    this.title,
    this.message,
    this.data,
  });
  Map<String, dynamic> toJson() => {
        "uid": uid,
        "title": title,
        "message": message,
        "data": data,
  };
}