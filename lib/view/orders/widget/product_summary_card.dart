import 'package:blueberry/view/orders/model/order_response.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ProductSummaryCard extends StatelessWidget {
  final OrderItems product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductSummaryCard({required this.product, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 0, 8),
      margin: EdgeInsets.only(top: 4, bottom: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: radius(14),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------------- Header ----------------
          Row(
            children: [
              Text(product.product?.name.validate() ?? '', style: boldTextStyle(size: 16)).expand(),
              8.width,
              IconButton(icon: const Icon(Icons.edit, size: 18), onPressed: onEdit, visualDensity: VisualDensity.compact, style: ButtonStyle()),
              IconButton(
                visualDensity: VisualDensity.compact,
                style: ButtonStyle(),
                icon: const Icon(Icons.delete_outline, color: Colors.red, size: 18),
                onPressed: onDelete,
              ),
            ],
          ),

          2.height,

          // ---------------- Qty & Marking ----------------
          Row(
            children: [
              _InfoChip(icon: Icons.confirmation_number_outlined, label: "Qty: ${product.quantity.validate()}").expand(),
              8.width,
              if (product.marking.validate().isNotEmpty) _InfoChip(icon: Icons.label_outline, label: product.marking.validate()).expand(),
            ],
          ),

          if (product.packaging.validate().isNotEmpty) ...[12.height, Text(product.packaging.validate().map((e) => e.toString()).join(", "), style: primaryTextStyle(size: 12))],
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.grey.shade700),
        6.width,
        Text(label, style: secondaryTextStyle(size: 12)),
      ],
    );
  }
}
