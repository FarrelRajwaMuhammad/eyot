import 'package:eyot/core/material/color_material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionWidget extends StatefulWidget {
  VersionWidget({super.key});

  @override
  State<VersionWidget> createState() => _VersionWidget();
}

class _VersionWidget extends State<VersionWidget> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      _version = packageInfo.version;
    });

    print("App version: $_version");
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "© 2025 E.Y.O.T. All rights reserved.  •  Version $_version",
      style: GoogleFonts.kayPhoDu(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        foreground: Paint()
          ..shader = const LinearGradient(
            colors: [
              Color(0xFF0D47A1), // Biru tua
              Color(0xFF1976D2), // Biru terang
            ],
          ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
        shadows: [
          const Shadow(
            offset: Offset(1, 1),
            blurRadius: 2,
            color: Colors.grey,
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
