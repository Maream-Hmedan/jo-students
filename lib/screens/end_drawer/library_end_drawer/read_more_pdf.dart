import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PdfViewerController extends GetxController {
  var localFilePath = RxnString();
  var isLoading = true.obs;

  Future<void> downloadPdf(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      final bytes = response.bodyBytes;

      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/downloaded.pdf');
      await file.writeAsBytes(bytes, flush: true);

      localFilePath.value = file.path;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to load PDF: $e');
    }
  }
}
class PdfViewerScreen extends StatelessWidget {
  final String url;
  PdfViewerScreen({super.key, required this.url});

  final PdfViewerController pdfViewerController = Get.put(PdfViewerController());

  @override
  Widget build(BuildContext context) {
    pdfViewerController.downloadPdf(url);

    return PopScope(
        canPop: true,
        onPopInvokedWithResult: (bool didPop, Object? result)  async {
      Get.delete<PdfViewerController>();
    },
      child: SafeArea(
        child: Scaffold(
          body: Obx(() {
            if (pdfViewerController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            return pdfViewerController.localFilePath.value != null
                ? PDFView(
              filePath: pdfViewerController.localFilePath.value,
            )
                : const Center(child: Text('Error loading PDF'));
          }),
        ),
      ),
    );
  }
}

