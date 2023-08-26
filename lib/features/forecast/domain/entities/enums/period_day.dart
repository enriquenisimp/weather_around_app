enum PeriodOfDay {
  unknown,
  morning,
  afternoon,
  evening,
  night;

  bool get isUnknown => this == unknown;
  bool get isMorning => this == morning;
  bool get isAfternoon => this == afternoon;
  bool get isEvening => this == evening;
  bool get isNight => this == night;

  static PeriodOfDay calculateByHour(int isDay, DateTime dateTime) {
    if (isDay == 0) return PeriodOfDay.night;

    if (dateTime.hour < 11) {
      return PeriodOfDay.morning;
    }

    if (dateTime.hour < 16) {
      return PeriodOfDay.afternoon;
    }

    return PeriodOfDay.evening;
  }
}
