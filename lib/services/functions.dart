import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Functions {
  Future<void> sharePost({String? title, required String url}) =>
      Share.share(url, subject: title);
      
  Future<void> shareApp() => Share.share(
      'https://play.google.com/store/apps/details?id=com.cyberav3s.evoln',
      subject: 'Enjoy Reading news articles with Evoln News');

  Future<void> launchSourceUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
  
  Future<void> sendReport() async {
    final url = "mailto:NinjaXSploit@gmail.com";
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> privacyPolicy() async {
    String url = 'https://docs.google.com/document/d/1RYbAoWdA22oqVfQu3v048IMlXxsuRTwAmyPdRcG8s4g/edit?usp=drivesdk';
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> termsOfUses() async {
    String url = 'https://docs.google.com/document/d/1jkjo61XnRtHtIdmzAtRrAIwfAywCtOQg2V5P_mH0zkw/edit?usp=sharing';
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> followOnTwitter() async {
    String url = 'https://twitter.com/burgeflow';
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> followOnInstagram() async {
    String url = 'https://www.instagram.com/burgeflow/';
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> followOnYoutube() async {
    String url = 'https://www.youtube.com/channel/UCax0Sn3e_ZEf11rsvCtnnng';
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
