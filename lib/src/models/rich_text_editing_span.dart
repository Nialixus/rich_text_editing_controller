part of '../../rich_text_editing_controller.dart';

class RichTextEditingSpan extends TextSpan {
  RichTextEditingSpan({
    required this.deltas,
    super.style,
  }) : super(children: _parse(deltas), text: '');

  final List<TextEditingDelta> deltas;

  static List<InlineSpan> _parse(List<TextEditingDelta> deltas) {
    var span = <InlineSpan>[];

    void tryCatch(
      void Function() callback,
      void Function(Object) onError,
    ) {
      try {
        callback();
      } catch (e) {
        onError(e);
      }
    }

    for (var delta in deltas) {
      if (delta is TextEditingDeltaInsertion) {
        tryCatch(() {
          int start = delta.selection.end - delta.textInserted.runes.length;
          span.insertAll(start, [
            for (var text in delta.textInserted.runes.string.split(''))
              TextSpan(text: text)
          ]);
        }, (e) => print('INSERTION ERROR: $e'));
      } else if (delta is TextEditingDeltaDeletion) {
        tryCatch(() {
          span.removeRange(delta.deletedRange.start, delta.deletedRange.end);
        }, (e) => print('DELETION ERROR: $e'));
        // span.removeRange(delta.deletedRange.start, delta.deletedRange.end);
      } else if (delta is TextEditingDeltaReplacement) {
        tryCatch(() {
          span.removeRange(delta.replacedRange.start, delta.replacedRange.end);
          span.insertAll(delta.replacedRange.start, [
            for (var text in delta.replacementText.runes.string.split(''))
              TextSpan(text: text)
          ]);
        }, (e) => print('REPLACEMENT ERROR: $e'));
        // span.removeRange(delta.replacedRange.start, delta.replacedRange.end);
        // span.insertAll(delta.replacedRange.start, [
        //   for (var text in delta.replacementText.runes.string.split(''))
        //     TextSpan(text: text)
        // ]);
      }
    }

    return span;
  }
}
