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
                color: primary,
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
        leadingWidth: 100.w,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.phone_fill,
              color: primary,
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
                  color: primary,
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
                  colors: [primary, red],
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        offset: const Offset(0, 10),
                        blurRadius: 5,
                        spreadRadius: 3,
                      ),
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 5),
                        blurRadius: 2,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: imageUrl.isEmpty
                      ? const Center(
                          child: Text("No image"),
                        )
                      : Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          scale: 1.0,
                        ),
                ),
                Positioned(
                  left: 80,
                  child: Container(
                    height: 44.h,
                    width: 48.w,
                    decoration: BoxDecoration(
                      color: primary.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Container(
                        height: 25.h,
                        width: 25.w,
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            width: 2,
                            color: Colors.white,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
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
                      color: primary,
                    ),
                    label: Text(
                      "Edit",
                      style: GoogleFonts.roboto(
                        color: primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        primary.withOpacity(0.4),
                      ),
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
                tileColor: Theme.of(context).primaryColor.withOpacity(0.2),
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
                tileColor: Theme.of(context).primaryColor.withOpacity(0.2),
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
                tileColor: Theme.of(context).primaryColor.withOpacity(0.2),
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
                tileColor: Theme.of(context).primaryColor.withOpacity(0.2),
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
