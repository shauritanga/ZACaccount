import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    super.key,
    this.statusColor,
    this.color = Colors.black,
    required this.title,
    required this.status,
    required this.icon,
    required this.amount,
    this.onTap,
  });
  final Color color;
  final Color? statusColor;
  final String title;
  final String status;
  final IconData icon;
  final double amount;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  Row(
                    children: [
                      const Text(
                        "Aug 4, 2024",
                        style: TextStyle(color: Colors.grey, fontSize: 13.0),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 1.0,
                        height: 13,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 13.0,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
          Expanded(
            child: Text(
              NumberFormat.currency(
                      locale: "sw-TZ", symbol: "Tsh", decimalDigits: 2)
                  .format(amount),
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }
}
