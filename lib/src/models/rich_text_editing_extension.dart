part of '../../rich_text_editing.dart';

extension RichTextEditingOffsetExtension on Offset {
  bool contains(int value) {
    return value >= dx && value <= dy;
  }
}

extension RichTextEditingDeltaExtension on TextEditingDelta {
  void then(void Function(TextEditingDelta?) callback) {
    callback(this);
  }
}

extension RichTextEditingValueExtension on TextEditingValue {
  TextEditingDelta? compareTo(TextEditingValue other) {
    int min(int value, [int? max]) {
      if (value < 0) return 0;
      if (value.isNaN) return 0;
      if (max != null && value > max) return max;
      return value;
    }

    String oldText = text.substring(
      min(selection.start),
      min(selection.end),
    );

    String newText = other.text.substring(
      min(selection.start, other.selection.end),
      min(other.selection.end),
    );

    bool isReplace = oldText.isNotEmpty &&
        newText.isNotEmpty &&
        oldText != newText &&
        text != other.text;
    bool isDelete = other.text.length < text.length;
    bool isInsert = other.text.length > text.length;
    bool isDuplicate = other.text == text &&
        other.selection.start == selection.start &&
        other.selection.end == selection.end;

    if (!isDuplicate) {
      if (isReplace) {
        return TextEditingDeltaReplacement(
            oldText: text,
            replacedRange: selection,
            replacementText: newText,
            selection: other.selection,
            composing: other.composing);
      } else if (isDelete) {
        return TextEditingDeltaDeletion(
            oldText: text,
            deletedRange: TextRange(
              start: min(other.selection.start),
              end: min(selection.end),
            ),
            selection: other.selection,
            composing: other.composing);
      } else if (isInsert) {
        return TextEditingDeltaInsertion(
            oldText: text,
            textInserted: newText,
            insertionOffset: selection.start,
            selection: other.selection,
            composing: other.composing);
      } else {
        return TextEditingDeltaNonTextUpdate(
            oldText: text,
            selection: other.selection,
            composing: other.composing);
      }
    }

    return null;
  }
}

extension OnTextStyle on TextStyle {
  Map<String, dynamic> get toJSON {
    return {};
  }
}
