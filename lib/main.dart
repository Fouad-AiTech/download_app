import "src/config/index.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    NotificationsService.init(),
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Downloader App',
      debugShowCheckedModeBanner: false,
      home: DownloadScreen(),
    );
  }
}
