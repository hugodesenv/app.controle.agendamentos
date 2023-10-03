import 'package:url_launcher/url_launcher_string.dart';

class LauncherUtils {
  LauncherUtils._();

  static final instance = LauncherUtils._();

  Future<bool> launchWhatsApp(String number) async {
    var whatsappUrl = 'whatsapp://send?phone=$number';
    return await canLaunchUrlString(whatsappUrl) ? await launchUrlString(whatsappUrl) : false;
  }
}
