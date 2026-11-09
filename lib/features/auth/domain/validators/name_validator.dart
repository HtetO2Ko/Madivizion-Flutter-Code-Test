class NameValidator {
  NameValidator._();

  static final RegExp _myanmarCharacters = RegExp(
    r'[\u1000-\u109F\uAA60-\uAA7F]',
  );

  static final RegExp _englishCharacters = RegExp(r'[a-zA-Z]');

  static final RegExp _lettersAndSpaces = RegExp(
    r'^[\p{L}\p{M} ]+$',
    unicode: true,
  );

  static bool isMyanmarOnlyName(String value) {
    final name = value.trim();

    return _myanmarCharacters.hasMatch(name) &&
        !_englishCharacters.hasMatch(name);
  }

  static bool isValidFirstName(String value) {
    final name = value.trim();

    return name.isNotEmpty &&
        name.length <= 50 &&
        _lettersAndSpaces.hasMatch(name);
  }

  static bool isValidLastName(String value) {
    final name = value.trim();

    return name.isEmpty ||
        (name.length <= 50 && _lettersAndSpaces.hasMatch(name));
  }
}
