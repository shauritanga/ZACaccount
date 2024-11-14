import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zaccount/presentation/providers/activity_provider.dart';
import 'package:zaccount/screens/product_details.dart';
import 'package:zaccount/widgets/custom_list_item.dart';

class Activity extends ConsumerWidget {
  const Activity({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activities = ref.watch(activitiyFutureProvider);
    return switch (activities) {
      AsyncData(:final value) => ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: value.length + 1,
          itemBuilder: (context, index) {
            if (index == value.length) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Show more",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              );
            }
            if (value.isEmpty) {
              return const Text("No any activity");
            }

            final activity = value[index];

            return CustomListItem(
              icon: activity.icon,
              color: activity.type.toLowerCase() == "product"
                  ? Theme.of(context).colorScheme.secondary
                  : activity.type.toLowerCase() == "customer"
                      ? Colors.purple
                      : Colors.black,
              title: activity.name,
              status: activity.status,
              amount: activity.amount,
              statusColor: activity.type.toLowerCase() == "product" ||
                      activity.type.toLowerCase() == "customer"
                  ? Colors.purple
                  : activity.type.toLowerCase() == "invoice"
                      ? Colors.blue
                      : Colors.black,
              onTap: () {
                if (activity.type == "product") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const ProductDetails(),
                    ),
                  );
                  return;
                }
              },
            );
          },
        ),
      AsyncError(:final error) => Text('Error: $error'),
      _ => const CupertinoActivityIndicator(),
    };
  }
}
