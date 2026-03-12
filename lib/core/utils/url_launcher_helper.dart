import 'package:url_launcher/url_launcher.dart';

Future<void> launchExternalUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

Future<void> launchMailto(String email, {String? subject}) async {
  final uri = Uri(
    scheme: 'mailto',
    path: email,
    query: subject != null ? 'subject=$subject' : null,
  );
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  }
}

Future<void> launchTel(String phone) async {
  final uri = Uri(scheme: 'tel', path: phone);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  }
}
