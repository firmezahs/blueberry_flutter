import 'package:blueberry/network/api_client.dart';
import 'package:flutter/material.dart';

class OrderNotesCard extends StatelessWidget {
  final String note;

  const OrderNotesCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    if (note.isEmpty) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(16), boxShadow: defaultBoxShadow()),
      child: Row(
        children: [
          const Icon(Icons.info, color: Colors.orange),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("NOTES", style: secondaryTextStyle(size: 12)),
                Text(note, style: boldTextStyle(size: 18)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
