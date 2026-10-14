import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  static Future<bool> openMapDirections(String destinationName) async {
    final query = Uri.encodeComponent('$destinationName Nairobi Kenya');
    final uri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
    return false;
  }

  static Future<bool> openWebUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
    return false;
  }
}
