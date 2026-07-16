//Switch Environment
bool isLive = false;

//Live url here
String liveUrl = '';
String stagingUrl = '';

class NetworkConfig {
  String baseUrl = isLive ? liveUrl : stagingUrl;
}
