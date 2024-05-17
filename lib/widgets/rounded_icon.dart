import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RoundedIcon extends StatelessWidget {
  const RoundedIcon({Key? key, required this.imageUrl, required this.url})
      : super(key: key);
  final String imageUrl;
  final String url;

  Future<void> _launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
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
                  color: Colors.black26, offset: Offset(0, 2), blurRadius: 0.6),
            ],
            image: DecorationImage(
              image: AssetImage(imageUrl),
            )),
      ),
    );
  }
}
