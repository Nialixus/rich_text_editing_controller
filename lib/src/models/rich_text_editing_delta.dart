part of '../../rich_text_editing.dart';

class RichTextEditingDelta<T extends TextEditingDelta> {
  const RichTextEditingDelta({
    this.isActive = true,
    required this.value,
    this.style = const TextStyle(),
  });

  final bool isActive;
  final T value;
  final TextStyle style;

  String get id {
    return RegExp(r".(?<=#)\w+(?=\()").firstMatch('$value')?.group(0) ?? '#';
  }

  RichTextEditingDelta<T> copyWith({
    bool? isActive,
    T? value,
    TextStyle? style,
  }) {
    return RichTextEditingDelta<T>(
      isActive: isActive ?? this.isActive,
      value: value ?? this.value,
      style: style ?? this.style,
    );
  }

  Map<String, dynamic> get toJSON {
    return {
      'id': id,
      'active': isActive,
      'value': value,
      'style': style.toJSON,
    };
  }
}

class RichTextEditingDeltaInsertion
    extends RichTextEditingDelta<TextEditingDeltaInsertion> {
  const RichTextEditingDeltaInsertion({
    required super.value,
    super.style = const TextStyle(),
    super.isActive = true,
  });

  @override
  RichTextEditingDeltaInsertion copyWith({
    bool? isActive,
    TextEditingDeltaInsertion? value,
    TextStyle? style,
  }) {
    return RichTextEditingDeltaInsertion(
      isActive: isActive ?? this.isActive,
      value: value ?? this.value,
      style: style ?? this.style,
    );
  }
}

class RichTextEditingDeltaDeletion
    extends RichTextEditingDelta<TextEditingDeltaDeletion> {
  const RichTextEditingDeltaDeletion({
    required super.value,
    super.style = const TextStyle(),
    super.isActive = true,
  });

  @override
  RichTextEditingDeltaDeletion copyWith({
    bool? isActive,
    TextEditingDeltaDeletion? value,
    TextStyle? style,
  }) {
    return RichTextEditingDeltaDeletion(
      isActive: isActive ?? this.isActive,
      value: value ?? this.value,
      style: style ?? this.style,
    );
  }
}

class RichTextEditingDeltaReplacement
    extends RichTextEditingDelta<TextEditingDeltaReplacement> {
  const RichTextEditingDeltaReplacement({
    required super.value,
    super.style = const TextStyle(),
    super.isActive = true,
  });

  @override
  RichTextEditingDeltaReplacement copyWith({
    bool? isActive,
    TextEditingDeltaReplacement? value,
    TextStyle? style,
  }) {
    return RichTextEditingDeltaReplacement(
      isActive: isActive ?? this.isActive,
      value: value ?? this.value,
      style: style ?? this.style,
    );
  }
}

class RichTextEditingDeltaNonTextUpdate
    extends RichTextEditingDelta<TextEditingDeltaNonTextUpdate> {
  const RichTextEditingDeltaNonTextUpdate({
    required super.value,
    super.style = const TextStyle(),
    super.isActive = true,
  });

  @override
  RichTextEditingDeltaNonTextUpdate copyWith({
    bool? isActive,
    TextEditingDeltaNonTextUpdate? value,
    TextStyle? style,
  }) {
    return RichTextEditingDeltaNonTextUpdate(
      isActive: isActive ?? this.isActive,
      value: value ?? this.value,
      style: style ?? this.style,
    );
  }
}
