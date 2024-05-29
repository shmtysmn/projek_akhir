import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RoundedIcon extends StatelessWidget {
  const RoundedIcon({Key? key, required this.imageUrl, required this.url})
      : super(key: key);
  final String imageUrl;
  final String url;

  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchURL,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 0.6,
            ),
          ],
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class SocialIconsRow extends StatelessWidget {
  const SocialIconsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        RoundedIcon(
          imageUrl: "assets/images/facebook.png",
          url: 'https://www.facebook.com/login/',
        ),
        SizedBox(
          width: 20,
        ),
        RoundedIcon(
          imageUrl: "assets/images/twitter.png",
          url: 'https://twitter.com/i/flow/login',
        ),
        SizedBox(
          width: 20,
        ),
        RoundedIcon(
          imageUrl: "assets/images/google.jpg",
          url:
              'https://myaccount.google.com/?utm_source=sign_in_no_continue&pli=1',
        ),
      ],
    );
  }
}
