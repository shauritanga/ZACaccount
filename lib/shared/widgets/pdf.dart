import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<File> createPdf() async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(build: (pw.Context context) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("INVOICE"),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text("Dalali Inc"),
                  pw.Text("Monduli District,Arusha,00000"),
                  pw.Text("TIN: 56-8767767"),
                ],
              )
            ],
          ),
          pw.SizedBox(height: 16),
          pw.RichText(
            text: const pw.TextSpan(
              text: "Dear, ",
              style: pw.TextStyle(color: PdfColors.grey600),
              children: [
                pw.TextSpan(
                  text: "Ashauri (shauritangaathanas)",
                  style: pw.TextStyle(
                    color: PdfColors.black,
                  ),
                )
              ],
            ),
          ),
          pw.SizedBox(height: 8),
          pw.Text(
            "Thank you for your business.We look forward to serving you again soon!Here is your order details",
          ),
          pw.Divider(),
          pw.SizedBox(height: 16),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    "Invoice No",
                    style: const pw.TextStyle(color: PdfColors.grey600),
                  ),
                  pw.Text(
                    "1005",
                  ),
                ],
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Text(
                    "Invoice Date",
                    style: const pw.TextStyle(color: PdfColors.grey600),
                  ),
                  pw.Text(
                    DateFormat.yMMMd().format(
                      DateTime.now(),
                    ),
                  ),
                ],
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(
                    "Due Date",
                    style: const pw.TextStyle(color: PdfColors.grey600),
                  ),
                  pw.Text(
                    DateFormat.yMMMd().format(
                      DateTime.now(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 16),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    "Bill To",
                    style: const pw.TextStyle(color: PdfColors.grey200),
                  ),
                ],
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(
                    "Shipped To",
                    style: const pw.TextStyle(color: PdfColors.grey600),
                  ),
                ],
              ),
            ],
          )
        ],
      );
    }),
  );

  // // Print preview or save as file
  // await Printing.layoutPdf(
  //     onLayout: (PdfPageFormat format) async => pdf.save());

  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/invoice-1008.pdf';

  // Save the PDF to the file
  final file = File(filePath);
  File invoice = await file.writeAsBytes(await pdf.save());
  return invoice;
}
