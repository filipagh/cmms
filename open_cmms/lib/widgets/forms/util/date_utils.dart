convertDatetimeToUtc(DateTime? date) {
  if (date == null) {
    return null;
  }
  return DateTime.utc(
    date.year,
    date.month,
    date.day,
    date.hour,
    date.minute,
    date.second,
    date.millisecond,
    date.microsecond,
  );
}
