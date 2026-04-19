import 'package:equatable/equatable.dart';

class KeyboardState extends Equatable {
  final bool isShiftActive;
  final bool isArabic;
  final String inputText;

  const KeyboardState({
    this.isShiftActive = false,
    this.isArabic = true,
    this.inputText = '',
  });

  KeyboardState copyWith({
    bool? isShiftActive,
    bool? isArabic,
    String? inputText,
  }) {
    return KeyboardState(
      isShiftActive: isShiftActive ?? this.isShiftActive,
      isArabic: isArabic ?? this.isArabic,
      inputText: inputText ?? this.inputText,
    );
  }

  @override
  List<Object?> get props => [isShiftActive, isArabic, inputText];
}
