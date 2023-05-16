import 'package:url_launcher/url_launcher_string.dart';

class LauncherRepository {
  LauncherRepository._();

  static final instance = LauncherRepository._();

  Future<bool> launchWhatsApp(String number) async {
    var whatsappUrl = 'whatsapp://send?phone=$number';
    return await canLaunchUrlString(whatsappUrl) ? await launchUrlString(whatsappUrl) : false;
  }
}
