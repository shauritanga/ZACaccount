import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zaccount/presentation/providers/distric_provider.dart';

class RegionsScreen extends ConsumerStatefulWidget {
  const RegionsScreen({required this.selected, super.key});
  final String selected;

  @override
  ConsumerState<RegionsScreen> createState() => _RegionsScreenState();
}

class _RegionsScreenState extends ConsumerState<RegionsScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(districtFutureProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          const Align(
            alignment: Alignment.center,
            child: Text(
              "Regions",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 18.h),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
              isDense: true,
              filled: true,
              fillColor: const Color(0xffe5e7eb),
              prefixIcon: const Icon(CupertinoIcons.search),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            style: const TextStyle(fontSize: 14), // Adjust text size as needed
            textAlignVertical: TextAlignVertical.center,
            onChanged: (value) {
              ref.read(searchQueryProvider.notifier).state = _controller.text;
            },
          ),
          Expanded(
            child: asyncValue.when(
              data: (data) {
                final districts = data
                    .where(
                      (district) => district.region.toLowerCase().contains(
                            searchQuery.toLowerCase(),
                          ),
                    )
                    .toList();

                final regions = districts
                    .map((district) => district.region)
                    .toSet()
                    .toList();
                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final region = regions[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.only(left: 16),
                      title: Text(
                        region,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: widget.selected == region
                          ? const Icon(CupertinoIcons.check_mark)
                          : const SizedBox(
                              width: 10,
                              height: 10,
                            ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      indent: 16.0,
                      height: 4.0,
                    );
                  },
                  itemCount: regions.length,
                );
              },
              error: (error, stackTrace) => Center(
                child: Text(error.toString()),
              ),
              loading: () => const Center(
                child: CupertinoActivityIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
