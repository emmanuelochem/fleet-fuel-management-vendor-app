//Switch Environment
bool isLive = false;

//Live url here
String liveUrl = '';

//Staging base url here
// String stagingUrl =
//     'http://ec2-13-41-197-98.eu-west-2.compute.amazonaws.com/api/v1/';
String stagingUrl = '';

class NetworkConfig {
  String baseUrl = isLive ? liveUrl : stagingUrl;
}
