import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:rosheta_ui/generated/l10n.dart';

class ShowFileScreen extends StatefulWidget {
  final Uint8List? serverData;
  final String ext;

  const ShowFileScreen({super.key, required this.serverData , required this.ext});

  @override
  _ShowFileScreenState createState() => _ShowFileScreenState();
}

class _ShowFileScreenState extends State<ShowFileScreen> {
  int pages = 0;
  bool isReady = false;
  final Completer<PDFViewController> _controller = Completer<PDFViewController>();

  @override
  void initState() {
    super.initState();
    if (widget.serverData != null) {
      setState(() {
        isReady = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          S.of(context).title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: widget.serverData != null
              ? widget.ext == ".pdf" ? PDFView(
                  pdfData: widget.serverData!,
                  enableSwipe: true,
                  swipeHorizontal: false,
                  autoSpacing: true,
                  pageFling: true,
                  onRender: (pages) {
                    setState(() {
                      pages = pages!;
                      isReady = true;
                    });
                  },
                  onViewCreated: (PDFViewController pdfViewController) {
                    _controller.complete(pdfViewController);
                  },
                  onPageChanged: (int? page, int? total) {},
                ) : Image.memory(widget.serverData!)
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
