part of '../../rich_text_editing.dart';

class RichTextEditingSpan extends TextSpan {
  RichTextEditingSpan({
    required this.deltas,
    required String text,
    super.style,
  }) : super(children: _parse(deltas, text: text));

  final List<TextEditingDelta> deltas;

  static List<InlineSpan> _parse(
    List<TextEditingDelta> deltas, {
    String text = '',
  }) {
    var span = <InlineSpan>[];

    for (var delta in deltas) {
      if (delta is TextEditingDeltaInsertion) {
        int start = delta.selection.end - delta.textInserted.runes.length;
        span.insertAll(start, [
          for (var text in delta.textInserted.runes.string.split(''))
            TextSpan(text: text)
        ]);
      } else if (delta is TextEditingDeltaDeletion) {
        int limiter(int value) {
          return value > text.runes.length ? text.runes.length : value;
        }

        span.removeRange(
          limiter(delta.deletedRange.start),
          limiter(delta.deletedRange.end),
        );
        // span.removeRange(delta.deletedRange.start, delta.deletedRange.end);
      } else if (delta is TextEditingDeltaReplacement) {
        span.removeRange(delta.replacedRange.start, delta.replacedRange.end);
        span.insertAll(delta.replacedRange.start, [
          for (var text in delta.replacementText.runes.string.split(''))
            TextSpan(text: text)
        ]);

        // span.removeRange(delta.replacedRange.start, delta.replacedRange.end);
        // span.insertAll(delta.replacedRange.start, [
        //   for (var text in delta.replacementText.runes.string.split(''))
        //     TextSpan(text: text)
        // ]);
      }
    }

    // if (span.length > text.runes.length) {
    //   span.removeRange(text.runes.length, span.length);
    // }

    return span;
  }
}
