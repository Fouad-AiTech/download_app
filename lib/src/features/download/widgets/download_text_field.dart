import '/src/config/index.dart';

class DownloaderTextField extends StatefulWidget {
  final Function() onChanged;
  final TextEditingController urlController;
  const DownloaderTextField({super.key, required this.urlController, required this.onChanged});

  @override
  State<DownloaderTextField> createState() => _DownloaderTextFieldState();
}

class _DownloaderTextFieldState extends State<DownloaderTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onChanged: (value) {
          widget.onChanged();
        },
        controller: widget.urlController,
        decoration: InputDecoration(
          suffixIcon: widget.urlController.text.isEmpty
              ? IconButton(
                  onPressed: () {
                    _pasteClipboard();
                  },
                  icon: const Icon(Icons.paste_outlined))
              : IconButton(
                  onPressed: () {
                    widget.urlController.clear();
                    widget.onChanged();
                  },
                  icon: const Icon(Icons.clear),
                ),
          hintText: 'Enter the URL to download the file',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  // paste the content of clipboard into the textfield
  Future _pasteClipboard() async {
    final ClipboardData? clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    if (clipboardData?.text != null) {
      widget.urlController.text = clipboardData!.text!;
      widget.onChanged();
    }
  }
}
