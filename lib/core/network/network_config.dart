//Switch Environment
bool isLive = false;

//Live url here
String liveUrl =
    'http://ec2-13-41-70-227.eu-west-2.compute.amazonaws.com/api/v1/';

//Staging base url here
String stagingUrl =
    'http://ec2-13-41-70-227.eu-west-2.compute.amazonaws.com/api/v1/';

class NetworkConfig {
  String baseUrl = isLive ? liveUrl : stagingUrl;
}
