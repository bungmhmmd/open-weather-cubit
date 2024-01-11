part of 'temp_settings_cubit.dart';

enum TempUnit { celcius, fahrenheit }

class TempSettingsState extends Equatable {
  final TempUnit tempUnit;

  TempSettingsState({this.tempUnit = TempUnit.celcius});

  factory TempSettingsState.initial() {
    return TempSettingsState();
  }

  TempSettingsState copyWith({
    TempUnit? tempUnit,
  }) {
    return TempSettingsState(
      tempUnit: tempUnit ?? this.tempUnit,
    );
  }

  @override
  List<Object> get props => [tempUnit];
}
