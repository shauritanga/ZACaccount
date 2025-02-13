import "dart:convert";

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:google_fonts/google_fonts.dart";
import "package:hugeicons/hugeicons.dart";
import "package:zaccount/presentation/providers/company_provider.dart";
import "package:zaccount/screens/companm_legal_name.dart";
import "package:zaccount/utils/constants.dart";

class CountryPage extends ConsumerStatefulWidget {
  const CountryPage({super.key});

  @override
  ConsumerState createState() => _CountryPageState();
}

class _CountryPageState extends ConsumerState<CountryPage> {
  // This list will store the filtered search results
  List<Map<String, dynamic>> _filteredItems = [];
  bool _isSelected = false;
  String _selectedItem = "";
  double? latitude;
  double? longitude;

  // Controller for the search field
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initially, show all the items
    _filteredItems = countries;

    // Add listener to the search field to filter suggestions as the user types
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  String query = "";
  // Function to filter items based on search input
  void _onSearchChanged() {
    query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = countries
          .where((item) => item['name']!.toLowerCase().contains(query))
          .toList();
    });
  }

  Future<void> getCoordinates(String countryName) async {
    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$countryName&format=json');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data.isNotEmpty) {
          final location = data[0];
          double lat = double.parse(location['lat']);
          double lon = double.parse(location['lon']);
          setState(() {
            latitude = lat;
            longitude = lon;
          });
        } else {
          print('No results found for $countryName');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextFormField for search input
            Text(
              "In which country is your business operating in?",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search',
                suffixIcon: Icon(HugeIcons.strokeRoundedSearch01),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  // _filteredItems = [];

                  _isSelected = false;
                });
              },
            ),
            const SizedBox(height: 20),
            // Display the suggestion list
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: _filteredItems.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return ListTile(
                    textColor: _filteredItems[index]['name'] == _selectedItem
                        ? Theme.of(context).primaryColor
                        : Colors.black,
                    contentPadding: EdgeInsets.zero,
                    leading: Text(_filteredItems[index]['flag']),
                    title: Text(
                      _filteredItems[index]['name'],
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    trailing: _isSelected &&
                            _filteredItems[index]['name'] == _selectedItem
                        ? Icon(
                            HugeIcons.strokeRoundedTick02,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                    onTap: () {
                      // Update the search field with the selected item
                      // _searchController.text = _filteredItems[index]['name'];
                      _selectedItem = _filteredItems[index]['name'];

                      // Optionally, hide the suggestion list after selection
                      setState(() {
                        // _filteredItems = [];
                        _filteredItems = countries
                            .where((item) =>
                                item['name']!.toLowerCase().contains(query))
                            .toList();
                        _isSelected = true;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 24),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: TextButton(
          onPressed: () async {
            ref.read(companyProvider.notifier).updateCountry(_selectedItem);
            if (!context.mounted) return;
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const CompanyLegalNameScreen(),
              ),
            );
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color>(
              _selectedItem.isEmpty
                  ? Colors.grey.shade400
                  : Theme.of(context).primaryColor,
            ),
            foregroundColor: const WidgetStatePropertyAll<Color>(Colors.white),
            minimumSize: const WidgetStatePropertyAll<Size>(
              Size(double.infinity, 48),
            ),
            shape: WidgetStatePropertyAll<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
          child: const Text("Continue"),
        ),
      ),
    );
  }
}
