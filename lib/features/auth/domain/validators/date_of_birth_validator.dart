class DateOfBirthValidator {
  DateOfBirthValidator._();

  static const int minimumAge = 13;

  static String? validate(DateTime dateOfBirth, {DateTime? today}) {
    final currentDate = today ?? DateTime.now();

    // Confirm that the date is a real calendar date.
    final date = DateTime(dateOfBirth.year, dateOfBirth.month, dateOfBirth.day);

    if (date.year != dateOfBirth.year ||
        date.month != dateOfBirth.month ||
        date.day != dateOfBirth.day) {
      return 'Please select a valid date.';
    }

    final todayDate = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
    );

    if (date.isAfter(todayDate)) {
      return 'Date of birth cannot be in the future.';
    }

    var age = todayDate.year - date.year;

    final birthdayNotReached =
        todayDate.month < date.month ||
        (todayDate.month == date.month && todayDate.day < date.day);

    if (birthdayNotReached) {
      age--;
    }

    if (age < minimumAge) {
      return 'You must be at least $minimumAge years old.';
    }

    return null;
  }
}
