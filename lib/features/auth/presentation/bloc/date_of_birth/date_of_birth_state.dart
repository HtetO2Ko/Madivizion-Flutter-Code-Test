class DateOfBirthState {
  final DateTime? dateOfBirth;
  final String? errorMessage;
  final bool isLoading;

  const DateOfBirthState({
    this.dateOfBirth,
    this.errorMessage,
    this.isLoading = false,
  });

  bool get isValid => dateOfBirth != null;

  DateOfBirthState copyWith({
    DateTime? dateOfBirth,
    String? errorMessage,
    bool? isLoading,
    bool clearError = false,
  }) {
    return DateOfBirthState(
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
