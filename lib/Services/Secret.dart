class Secret {
  final String apiKey;
  Secret({this.apiKey = ""});
  factory Secret.fromJson(Map<String, dynamic> jsonMap){
    return Secret(apiKey: jsonMap["GOOGLE_MAPS_API_KEY"]);
  }
}