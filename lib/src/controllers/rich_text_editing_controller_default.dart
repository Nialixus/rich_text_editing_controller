part of '../../rich_text_editing.dart';

class DefaultRichTextEditingController extends StatefulWidget {
  const DefaultRichTextEditingController.fromValue({
    super.key,
    this.value,
    required this.child,
  });

  DefaultRichTextEditingController({
    super.key,
    String? text,
    required this.child,
  }) : value = RichTextEditingValue(text: text ?? '');

  final RichTextEditingValue? value;
  final Widget child;

  @override
  State<DefaultRichTextEditingController> createState() => _DRTECS();
}

class _DRTECS extends State<DefaultRichTextEditingController> {
  late final RichTextEditingController controller;

  @override
  void initState() {
    super.initState();

    if (widget.value != null) {
      controller = RichTextEditingController.fromValue(value: widget.value!);
    } else {
      controller = RichTextEditingController();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _RichTextEditingProvider(
      controller: controller,
      child: widget.child,
    );
  }
}
