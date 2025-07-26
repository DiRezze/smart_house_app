class Broker {

  Broker({
    required this.url,
    required this.user,
    required this.pass,
  });

  String url;
  String user;
  String pass;

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'user': user,
      'pass': pass,
    };
  }

  factory Broker.fromJson(Map<String, dynamic> json) {
    return Broker(
      url: json['url'],
      user: json['user'],
      pass: json['pass'],
    );
  }

}
