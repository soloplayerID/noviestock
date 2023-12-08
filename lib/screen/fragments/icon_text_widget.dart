import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class AppIconText extends StatelessWidget {
  final IconData icon;
  final String text;
  final String destination;
  const AppIconText(
      {super.key,
      required this.icon,
      required this.text,
      required this.destination});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xff8FC20F)),
          const Gap(10),
          Text(
            text,
            style: GoogleFonts.nunito(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4c4c4c),
            ),
          ),
          const Spacer(),
          Text(
            destination,
            style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xff8FC20F),
            ),
          ),
        ],
      ),
    );
  }
}
