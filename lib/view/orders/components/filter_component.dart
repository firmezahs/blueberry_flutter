import 'package:blueberry/main.dart';
import 'package:blueberry/network/api_client.dart';
import 'package:flutter/material.dart';

class FilterComponent extends StatelessWidget {
  final bool urgentOnly;
  final String status;
  final ValueChanged<bool> onUrgentChanged;
  final ValueChanged<String> onStatusChanged;

  const FilterComponent({super.key, required this.urgentOnly, required this.status, required this.onUrgentChanged, required this.onStatusChanged});

  @override
  Widget build(BuildContext context) {
    final statuses = appStore.orderStatus?.data.validate() ?? [];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          /// 🔴 Urgent Only
          FilterChip(
            label: Text('Urgent Only', style: boldTextStyle(size: 12)),
            selected: urgentOnly,
            selectedColor: Colors.red.shade100,
            onSelected: onUrgentChanged,
            padding: EdgeInsets.all(0),
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),

          const SizedBox(width: 8),

          // /// 🔵 All
          // FilterChip(
          //   label: Text('All', style: boldTextStyle(size: 12)),
          //   selected: status == 'All',
          //   onSelected: (_) => onStatusChanged('All'),
          //   padding: EdgeInsets.all(0),
          //   visualDensity: VisualDensity.compact,
          //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          // ),

          /// 🟢 Dynamic Status Chips
          ...statuses.map((s) {
            return Padding(
              padding: const EdgeInsets.only(left: 8),
              child: FilterChip(
                label: Text(s, style: boldTextStyle(size: 12)),
                selected: status == s,
                onSelected: (_) => onStatusChanged(s),
                padding: EdgeInsets.all(0),
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
