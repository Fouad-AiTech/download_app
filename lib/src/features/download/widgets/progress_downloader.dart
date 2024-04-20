import '/src/config/index.dart';

class ProgressDownloader extends StatelessWidget {
  const ProgressDownloader({super.key, required this.progressDownloader});

  final double progressDownloader;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: progressDownloader > 0.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LinearPercentIndicator(
            width: MediaQuery.of(context).size.width - 50,
            lineHeight: 20.0,
            center: Text(
              "${(progressDownloader * 100).toStringAsFixed(2)}%",
              style: const TextStyle(fontSize: 12.0),
            ),
            barRadius: const Radius.circular(32),
            percent: progressDownloader,
            backgroundColor: Colors.grey,
            progressColor: Colors.purple[300],
          ),
        ],
      ),
    );
  }
}
