part of '../../rich_text_editing_controller.dart';

class RichTextEditingController extends TextEditingController {
  RichTextEditingController({super.text})
      : _value = RichTextEditingValue.fromValue(
          value: TextEditingValue(
            text: text ?? '',
          ),
        );

  RichTextEditingController.fromValue({
    required RichTextEditingValue value,
  }) : _value = value;

  List<TextEditingDelta> deltas = [];

  factory RichTextEditingController.of(BuildContext context) {
    final value = context
        .dependOnInheritedWidgetOfExactType<_RichTextEditingProvider>()
        ?.controller;

    if (value != null) return value;
    throw FlutterError(
      'RichTextEditingController.of() called with a context that does not contain a RichTextEditingController.\n'
      'No RichTextEditingController ancestor could be found starting from the context that was passed to RichTextEditingController.of().\n'
      'This can happen if the context you used comes from a widget above the RichTextEditingController.\n'
      'The context used was: $context',
    );
  }

  void setFontWeight({
    FontWeight? fontWeight,
  }) async {
    richValue = RichTextEditingValue(
      fontWeight: fontWeight,
      selection: value.selection,
      text: value.text,
      composing: value.composing,
    );
  }

  RichTextEditingValue _value;

  RichTextEditingValue get richValue {
    return RichTextEditingValue(
      fontWeight: _value.fontWeight,
      selection: value.selection,
      text: value.text,
      composing: value.composing,
    );
  }

  set richValue(RichTextEditingValue value) {
    _value = value;
    notifyListeners();
  }

  @override
  set value(TextEditingValue newValue) {
    var delta = value.compareTo(newValue);
    if (delta != null) deltas.add(delta);

    super.value = newValue;
  }

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    return RichTextEditingSpan(
      deltas: deltas,
      style: style,
    );
  }
}
