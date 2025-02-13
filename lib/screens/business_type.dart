import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zaccount/models/business_type.dart';
import 'package:zaccount/presentation/providers/company_provider.dart';
import 'package:zaccount/screens/business_name.dart';
import 'package:zaccount/shared/widgets/custom_tile.dart';

class BusinessTypeScreen extends ConsumerStatefulWidget {
  const BusinessTypeScreen({super.key});

  @override
  ConsumerState<BusinessTypeScreen> createState() => _BusinessTypeScreenState();
}

class _BusinessTypeScreenState extends ConsumerState<BusinessTypeScreen> {
  BusinessTypes _dataFilter = BusinessTypes.individual;
  bool _isModalOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            HugeIcons.strokeRoundedArrowLeft01,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "What's your business type?",
              style:
                  GoogleFonts.roboto(fontWeight: FontWeight.w800, fontSize: 20),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Icon(HugeIcons.strokeRoundedTools),
                const SizedBox(width: 8),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: Text(_dataFilter.description)),
                      IconButton(
                        icon: Icon(_isModalOpen
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down),
                        onPressed: () async {
                          setState(() {
                            _isModalOpen = true;
                          });
                          await showModalBottomSheet(
                            showDragHandle: true,
                            backgroundColor:
                                Theme.of(context).colorScheme.surface,
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(
                                      0) // Removes the top rounded corners
                                  ),
                            ),
                            builder: (context) {
                              return Container(
                                color: Theme.of(context).colorScheme.surface,
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    const Text(
                                      "Select a business type",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 16),
                                    CustomTile(
                                      title:
                                          BusinessTypes.individual.description,
                                      color: _dataFilter ==
                                              BusinessTypes.individual
                                          ? Theme.of(context).primaryColor
                                          : null,
                                      onTap: () {
                                        setState(() {
                                          _dataFilter =
                                              BusinessTypes.individual;
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                    const Divider(),
                                    CustomTile(
                                      title: BusinessTypes.llc.description,
                                      color: _dataFilter == BusinessTypes.llc
                                          ? Theme.of(context).primaryColor
                                          : null,
                                      onTap: () {
                                        setState(() {
                                          _dataFilter = BusinessTypes.llc;
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                    const Divider(),
                                    CustomTile(
                                      title: BusinessTypes
                                          .privateCompany.description,
                                      color: _dataFilter ==
                                              BusinessTypes.privateCompany
                                          ? Theme.of(context).primaryColor
                                          : null,
                                      onTap: () {
                                        setState(() {
                                          _dataFilter =
                                              BusinessTypes.privateCompany;
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                    const Divider(),
                                    CustomTile(
                                      title: BusinessTypes
                                          .publicCompany.description,
                                      color: _dataFilter ==
                                              BusinessTypes.publicCompany
                                          ? Theme.of(context).primaryColor
                                          : null,
                                      onTap: () {
                                        setState(() {
                                          _dataFilter =
                                              BusinessTypes.publicCompany;
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                    const Divider(),
                                    CustomTile(
                                      title:
                                          BusinessTypes.partnership.description,
                                      color: _dataFilter ==
                                              BusinessTypes.partnership
                                          ? Theme.of(context).primaryColor
                                          : null,
                                      onTap: () {
                                        setState(() {
                                          _dataFilter =
                                              BusinessTypes.partnership;
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                    const Divider(),
                                    CustomTile(
                                      title: BusinessTypes.other.description,
                                      color: _dataFilter == BusinessTypes.other
                                          ? Theme.of(context).primaryColor
                                          : null,
                                      onTap: () {
                                        setState(() {
                                          _dataFilter = BusinessTypes.other;
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              );
                            },
                          );
                          setState(() {
                            _isModalOpen = false;
                          });
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(8),
            child: TextButton(
              onPressed: () {
                ref
                    .read(companyProvider.notifier)
                    .updateBusinessType(_dataFilter);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const BusinessNameScreen(),
                  ),
                );
              },
              style: ButtonStyle(
                  foregroundColor:
                      const WidgetStatePropertyAll<Color>(Colors.white),
                  backgroundColor: WidgetStatePropertyAll<Color>(
                      Theme.of(context).primaryColor),
                  shape: WidgetStatePropertyAll<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  minimumSize: const WidgetStatePropertyAll<Size>(
                    Size(double.infinity, 48),
                  )),
              child: const Text("Continue"),
            ),
          )
        ],
      )),
    );
  }
}
