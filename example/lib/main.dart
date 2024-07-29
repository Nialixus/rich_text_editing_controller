import 'package:flutter/material.dart';
import 'package:rich_text_editing_controller/rich_text_editing_controller.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Rich Text Editing Controller',
      home: DefaultRichTextEditingController(
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = RichTextEditingController.of(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                minLines: 10,
                maxLines: null,
              ),
            ),
            Expanded(
              child: SelectionArea(
                child: ListenableBuilder(
                  listenable: controller,
                  builder: (context, _) {
                    return ListView.builder(
                        itemCount: controller.deltas.length,
                        itemBuilder: (context, index) {
                          return Text(
                              '${controller.deltas.reversed.elementAt(index)}\n');
                        });
                  },
                ),
              ),
            ),
            Row(
              children: [RichTextButton.fontWeight()],
            )
          ],
        ),
      ),
    );
  }
}
