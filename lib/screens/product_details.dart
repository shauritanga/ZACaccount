import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaccount/utils/constants.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  // String get imageUrl =>
  //     "https://images.unsplash.com/photo-1491553895911-0055eca6402d?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8c2hvZXN8ZW58MHx8MHx8fDA%3D";

  String get imageUrl => "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            child: Text(
              "Cancel",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
                fontSize: 20,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
              ),
            ),
          ),
        ),
        title: Text(
          "Strainer",
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leadingWidth: 120.w,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.phone_fill,
              color: Theme.of(context).primaryColor,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              child: Text(
                "Save",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.solid,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: 10,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Theme.of(context).primaryColor, red],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Stack(
              children: [
                Container(
                  height: 100.h,
                  width: 100.w,
                  margin: EdgeInsets.only(
                    left: 16.w,
                    top: 16.h,
                    right: 20.w,
                    bottom: 16.h,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: imageUrl.isEmpty
                      ? const Center(
                          child: Text(
                            "No image",
                          ),
                        )
                      : Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          scale: 1.0,
                        ),
                ),
                Positioned(
                  left: 95,
                  child: Center(
                    child: Center(
                      child: Icon(
                        CupertinoIcons.add_circled_solid,
                        color: Theme.of(context).primaryColor,
                        size: 27,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                "Stainer",
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                "American quality shoes",
                style: GoogleFonts.roboto(
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Additional details",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    iconAlignment: IconAlignment.end,
                    icon: Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).primaryColor,
                    ),
                    label: Text(
                      "Edit",
                      style: GoogleFonts.roboto(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ButtonStyle(
                      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Product cost",
                        style: GoogleFonts.roboto(
                          color: Colors.grey,
                        ),
                      ),
                      const Text("TZS 5,990,700"),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Sale price",
                        style: GoogleFonts.roboto(
                          color: Colors.grey,
                        ),
                      ),
                      const Text("TZS 9,990,700"),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Stock Quantity",
                        style: GoogleFonts.roboto(
                          color: Colors.grey,
                        ),
                      ),
                      const Text("TZS 5,990,700"),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Reorder Point",
                        style: GoogleFonts.roboto(
                          color: Colors.grey,
                        ),
                      ),
                      const Text("5"),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sales Tax",
                        style: GoogleFonts.roboto(
                          color: Colors.grey,
                        ),
                      ),
                      const Text("0%"),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: const Text("Category"),
                subtitle: Text(
                  "missing category",
                  style: GoogleFonts.roboto(
                    color: red,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: const Text("Income Account"),
                subtitle: Text(
                  "Please add income account",
                  style: GoogleFonts.roboto(
                    color: red,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: const Text("Expense Account"),
                subtitle: Text(
                  "Please add expense account",
                  style: GoogleFonts.roboto(
                    color: red,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: const Text("Preferred Vendor"),
                subtitle: Text(
                  "Missing preferred vendor",
                  style: GoogleFonts.roboto(
                    color: red,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
