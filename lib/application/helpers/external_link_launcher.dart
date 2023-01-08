import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    Logger().e("Could not launch $url");
  }
}
