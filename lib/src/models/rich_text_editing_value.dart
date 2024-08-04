part of '../../rich_text_editing.dart';

class RichTextEditingValue extends TextEditingValue {
  const RichTextEditingValue({
    this.fontWeight,
    super.composing,
    super.selection,
    super.text,
  });

  RichTextEditingValue.fromValue({
    required TextEditingValue value,
  })  : fontWeight = null,
        super(
          composing: value.composing,
          selection: value.selection,
          text: value.text,
        );

  final FontWeight? fontWeight;

  bool get isBold {
    if (fontWeight == null) return false;
    return fontWeight!.index >= FontWeight.w700.index;
  }
}
