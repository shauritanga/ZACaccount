import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zaccount/presentation/providers/invoice_provider.dart';
import 'package:zaccount/presentation/providers/order_provider.dart';
import 'package:zaccount/utils/send_invoice_email.dart';
import 'package:zaccount/shared/widgets/pdf.dart';
import 'package:screenshot/screenshot.dart';

class InvoicePreviewScreen extends ConsumerStatefulWidget {
  const InvoicePreviewScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InvoicePreviewScreenState();
}

class _InvoicePreviewScreenState extends ConsumerState<InvoicePreviewScreen> {
  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  Future<void> saveImage(Uint8List imageData, String fileName) async {
    // Get the application documents directory
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName.png';

    // Write the image to the file
    final file = File(filePath);
    await file.writeAsBytes(imageData);
  }

  @override
  Widget build(BuildContext context) {
    final invoive = ref.watch(invoiceProvider);
    final order = ref.watch(orderProvider);
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        leadingWidth: 100,
        actions: [
          IconButton(
            onPressed: () async {
              File pdf = await createPdf();
              await sendEmail(pdf);
            },
            icon: const Icon(CupertinoIcons.envelope),
          ),
          IconButton(
            onPressed: () {
              showMenu(context: context, position: RelativeRect.fill, items: [
                PopupMenuItem(
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Download image"),
                      Icon(
                        CupertinoIcons.arrow_down_circle,
                        size: 18,
                      )
                    ],
                  ),
                  onTap: () => createPdf(),
                ),
                PopupMenuItem(
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Download PDF"),
                      Icon(
                        CupertinoIcons.arrow_down_circle,
                        size: 18,
                      )
                    ],
                  ),
                  onTap: () async {
                    Uint8List? image = await screenshotController.capture();
                    saveImage(image!, "invoice");
                    // Handle the image (e.g., save to file, share, etc.)
                  },
                ),
              ]);
            },
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("INVOICE"),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Dalali Inc"),
                      Text("Monduli District,Arusha,00000"),
                      Text("TIN: 56-8767767"),
                    ],
                  )
                ],
              ),
              SizedBox(height: 16.h),
              RichText(
                text: TextSpan(
                  text: "Dear, ",
                  style: TextStyle(color: Colors.grey[600]),
                  children: [
                    TextSpan(
                      text: "${order.customerLastName} (shauritangaathanas)",
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              const Text(
                "Thank you for your business.We look forward to serving you again soon!Here is your order details",
              ),
              const Divider(),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Invoice No",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(invoive.invoiceNo),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Invoice Date",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(
                        DateFormat.yMMMd().format(invoive.invoiceDate),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Due Date",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(
                        DateFormat.yMMMd().format(invoive.dueDate),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bill To",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Shipped To",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
