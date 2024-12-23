import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw ;
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


class InvoiceScreen extends StatelessWidget {
  // Function to generate the PDF document
  Future<Uint8List> generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisSize: pw.MainAxisSize.min,
              children: [
                pw.Text('Invoice Generated:', style: pw.TextStyle(fontSize: 24)),
                pw.SizedBox(height: 20),
                pw.Text('Amount: \$500', style: pw.TextStyle(fontSize: 18)),
                pw.Text('Date: 23-Dec-2024', style: pw.TextStyle(fontSize: 18)),
                pw.Text('Items: Item A, Item B, Item C', style: pw.TextStyle(fontSize: 18)),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  // Function to save PDF to device
  Future<String> savePdf(Uint8List bytes) async {
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/invoice.pdf");
    await file.writeAsBytes(bytes);
    return file.path;
  }

  // Function to show the PDF in a viewer
  Future<void> viewPdf(BuildContext context) async {
    final pdfBytes = await generatePdf();
    final filePath = await savePdf(pdfBytes);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewerScreen(filePath: filePath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Invoice Generation")),
      body: Center(
        child: GestureDetector(
          onTap: () {
            viewPdf(context); // Generate and show the PDF
          },
          child: Card(
            elevation: 5,
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Click to Generate Invoice (PDF)', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PdfViewerScreen extends StatelessWidget {
  final String filePath;

  PdfViewerScreen({required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Invoice PDF")),
      body: Center(
        child: PDFView(
          filePath: filePath,
        ),
      ),
    );
  }
}
