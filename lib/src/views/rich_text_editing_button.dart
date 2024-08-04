part of '../../rich_text_editing.dart';

class RichTextButton extends StatelessWidget {
  const RichTextButton({
    super.key,
    this.controller,
    required this.builder,
  });
  final RichTextEditingController? controller;
  final Widget Function(
    BuildContext context,
    RichTextEditingController controller,
    Widget? child,
  ) builder;

  @override
  Widget build(BuildContext context) {
    final controller = this.controller ?? RichTextEditingController.of(context);
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) => builder(context, controller, child),
    );
  }

  /// [value] is
  factory RichTextButton.fontWeight({
    FontWeight? Function(FontWeight? value)? onChanged,
  }) {
    return RichTextButton(
      builder: (context, controller, child) {
        bool isBold = controller.richValue.isBold;
        ThemeData theme = Theme.of(context);
        return IconButton(
          onPressed: () {
            controller.setFontWeight(
              fontWeight: onChanged != null
                  ? onChanged(controller.richValue.fontWeight)
                  : isBold
                      ? null
                      : FontWeight.bold,
            );
          },
          icon: Icon(
            Icons.format_bold,
            color: isBold
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface,
          ),
        );
      },
    );
  }
}
