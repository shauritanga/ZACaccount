import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:google_fonts/google_fonts.dart";
import "package:hugeicons/hugeicons.dart";
import "package:zaccount/presentation/providers/company_provider.dart";
import "package:zaccount/screens/country_operate.dart";

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  // List of items that you want to show in the suggestion list
  final List<String> items = [
    'Apple',
    'Banana',
    'Mango',
    'Pineapple',
    'Orange',
    'Strawberry',
    'Grapes',
    'Watermelon',
    'Kiwi',
    'Peach',
    'balance',
    'show',
    'name'
  ];

  // This list will store the filtered search results
  List<String> _filteredItems = [];
  bool _isSelected = false;

  // Controller for the search field
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initially, show all the items
    _filteredItems = items;

    // Add listener to the search field to filter suggestions as the user types
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  // Function to filter items based on search input
  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems =
          items.where((item) => item.toLowerCase().contains(query)).toList();
    });
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
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextFormField for search input
            Text(
              "In what industry does your business operate?",
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
                    selectedColor: Theme.of(context).primaryColor,
                    contentPadding: EdgeInsets.zero,
                    title: Text(_filteredItems[index]),
                    trailing: _isSelected
                        ? const Icon(HugeIcons.strokeRoundedTick02)
                        : null,
                    onTap: () {
                      // Update the search field with the selected item
                      _searchController.text = _filteredItems[index];

                      // Optionally, hide the suggestion list after selection
                      setState(() {
                        // _filteredItems = [];
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
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: TextButton(
          onPressed: () {
            ref
                .read(companyProvider.notifier)
                .updateBusinessMcc(_searchController.text);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const CountryPage(),
              ),
            );
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color>(
              _searchController.text.isEmpty
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
