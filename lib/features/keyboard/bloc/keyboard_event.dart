import 'package:equatable/equatable.dart';

abstract class KeyboardEvent extends Equatable {
  const KeyboardEvent();

  @override
  List<Object?> get props => [];
}

class KeyPressed extends KeyboardEvent {
  final String character;
  const KeyPressed(this.character);

  @override
  List<Object?> get props => [character];
}

class BackspacePressed extends KeyboardEvent {
  const BackspacePressed();
}

class SpacePressed extends KeyboardEvent {
  const SpacePressed();
}

class EnterPressed extends KeyboardEvent {
  const EnterPressed();
}

class ShiftToggled extends KeyboardEvent {
  const ShiftToggled();
}

class LanguageToggled extends KeyboardEvent {
  const LanguageToggled();
}

class InputCleared extends KeyboardEvent {
  const InputCleared();
}
