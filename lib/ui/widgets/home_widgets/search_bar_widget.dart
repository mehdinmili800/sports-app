/* ===================== SearchBar (أصغر) ===================== */
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46, // كان 50
      decoration: BoxDecoration(
        color: const Color(0xFF1D1D1D),
        borderRadius: BorderRadius.circular(13),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.white70, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Search for trainers, spors, or gyms…',
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(color: Colors.white60, fontSize: 13),
            ),
          ),
          const Icon(Icons.tune_rounded, color: Colors.white, size: 18),
        ],
      ),
    );
  }
}