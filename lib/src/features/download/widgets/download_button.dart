import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

class DownloadButton extends StatelessWidget {
  final TextEditingController urlController;
  final ValueChanged<double> onProgress;

  const DownloadButton({
    Key? key,
    required this.urlController,
    required this.onProgress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 80,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _onPressed(context),
        child: const Text('Download'),
      ),
    );
  }

  void _onPressed(BuildContext context) {
    if (urlController.text.isEmpty) {
      _showSnackBar(context, 'Please enter a URL to download the file', Colors.red);
      return;
    }

    FileDownloader.downloadFile(
      url: urlController.text,
      onDownloadError: (errorMessage) => _showSnackBar(context, errorMessage, Colors.red),
      onDownloadCompleted: (path) {
        _showSnackBar(context, 'File downloaded successfully ', Colors.green);
        onProgress(0.0);
      },
      onProgress: (_, progress) => onProgress(progress),
    );
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}
