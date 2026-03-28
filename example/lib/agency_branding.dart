import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AgencyColors {
  AgencyColors._();

  static const LinearGradient instagramGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [Color(0xFFE1306C), Colors.white],
  );

  static const LinearGradient facebookGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [Color(0xFF1877F2), Colors.white],
  );

  static const LinearGradient tiktokGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [Color(0xFF25F4EE), Colors.white],
  );

  static const LinearGradient snapchatGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [Color(0xFF8B7D13), Colors.white],
  );
}

class AgencyAssets {
  AgencyAssets._();

  static const String _iconPath = 'assets/icons';

  static const String facebookReach = '$_iconPath/facebook_reach.svg';
  static const String instagramReach = '$_iconPath/instagram_reach.svg';
  static const String snapchatReach = '$_iconPath/Snapchat_reach.svg';
  static const String tiktokReach = '$_iconPath/TikTok_reach.svg';

  static Widget reachSvg(String assetPath) {
    return SvgPicture.asset(
      assetPath,
      fit: BoxFit.contain,
      alignment: Alignment.center,
    );
  }
}
