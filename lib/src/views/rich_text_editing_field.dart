part of '../../rich_text_editing.dart';

class RichTextEditingField extends StatelessWidget {
  const RichTextEditingField({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: (value) {},
      child: TextField(),
    );
  }
}
