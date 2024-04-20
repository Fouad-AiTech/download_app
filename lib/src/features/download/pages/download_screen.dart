import '/src/config/index.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({Key? key}) : super(key: key);

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> with WidgetsBindingObserver {
  double progress = 0.0;
  bool startDownload = false;
  final TextEditingController urlController = TextEditingController();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    handleNotification();
  }

  void handleNotification() {
    if (WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed || progress == 1.0) {
      startDownload = false;
      // App is in the foreground
      NotificationsService.cancelNotification(0);
    }
    if (WidgetsBinding.instance.lifecycleState == AppLifecycleState.paused && startDownload && progress != 0) {
      // App is in the background
      NotificationsService.showNotification(progress);
    }
  }

  @override
  void dispose() {
    urlController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Permission.notification.request();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('file Downloader'),
        centerTitle: true,
      ),
      body: Column(children: [
        const SizedBox(height: 30),
        Text(
          "Enter the URL to download the file",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 30),
        DownloaderTextField(
            urlController: urlController,
            onChanged: () {
              setState(() {});
            }),
        const SizedBox(height: 30),
        DownloadButton(
            urlController: urlController,
            onProgress: (value) {
              startDownload = true;
              setState(() {
                progress = (value * 0.01);
              });
              handleNotification();
            }),
        const SizedBox(height: 30),
        ProgressDownloader(progressDownloader: progress),
      ]),
    );
  }
}
