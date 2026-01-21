import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

List<String> allowedNextStatuses(String current) {
  log(current);
  switch (current) {
    case 'Pending':
      return ['Dispatched'];
    case 'partial':
      return ['Partial Dispatched'];
    case 'Partial Dispatched':
      return ['Dispatched'];
    default:
      return [current];
  }
}

class ChangeOrderStatusSheet extends StatefulWidget {
  final String currentStatus;
  final ValueChanged<String> onSubmit;

  const ChangeOrderStatusSheet({super.key, required this.currentStatus, required this.onSubmit});

  @override
  State<ChangeOrderStatusSheet> createState() => _ChangeOrderStatusSheetState();
}

class _ChangeOrderStatusSheetState extends State<ChangeOrderStatusSheet> {
  late String selectedStatus;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.currentStatus;
  }

  @override
  Widget build(BuildContext context) {
    final options = allowedNextStatuses(widget.currentStatus);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Change Order Status', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),

            ...options.map((status) {
              final isSelected = status == selectedStatus;
              final isCurrent = status == widget.currentStatus;

              return RadioListTile<String>(
                value: status,
                groupValue: selectedStatus,
                onChanged: isCurrent ? null : (v) => setState(() => selectedStatus = v!),
                title: Text(status),
                subtitle: isCurrent ? const Text('Current status') : null,
              );
            }),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(onPressed: selectedStatus == widget.currentStatus ? null : () => widget.onSubmit(selectedStatus), child: const Text('Submit')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> confirmStatusChange(BuildContext context, String newStatus) async {
  return await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          insetPadding: EdgeInsets.all(8),
          title: Text('Confirm Status Change'),
          content: Text('Are you sure you want to mark this order as "$newStatus"?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
            ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Confirm')),
          ],
        ),
      ) ??
      false;
}
