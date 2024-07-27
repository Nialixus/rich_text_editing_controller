part of '../../rich_text_editing_controller.dart';

class _RichTextEditingProvider extends InheritedWidget {
  const _RichTextEditingProvider({
    required this.controller,
    required super.child,
  });

  final RichTextEditingController controller;

  @override
  bool updateShouldNotify(covariant _RichTextEditingProvider oldWidget) {
    return controller != oldWidget.controller;
  }
}
