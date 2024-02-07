import 'package:flutter/material.dart';
import 'package:payment/core/utils/fallback_loading.dart';
import 'package:payment/core/utils/styles.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfView extends StatelessWidget {
  const PdfView({super.key, required this.linkPdf, required this.title});
  final String linkPdf;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text(title),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.file_download_outlined),
            ),
          ],
        ),
        body: FutureBuilder(
          future: null,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const FallbackLoading();
            } else if (snapshot.hasError) {
              return const FallbackLoading();
            } else {
              try {
                return SfPdfViewer.network(
                  linkPdf,
                  onDocumentLoaded: (v) {
                    const FallbackLoading();
                  },
                  onDocumentLoadFailed: (v) {
                    const FallbackLoading();
                  },
                );
              } catch (e) {
                return Center(
                  child: Text('we can not load the pdf',
                      style: Styles.textStyle18.copyWith(
                        color: Colors.red,
                      )),
                );
              }
            }
          },
        ));
  }
}
