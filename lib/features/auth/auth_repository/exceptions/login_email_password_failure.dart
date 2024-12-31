class LogInWithEmailAndPasswordFailure {
  final String message;

  const LogInWithEmailAndPasswordFailure([this.message = "An unknown error occurred."]);

  factory LogInWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case "user-not-found":
        return const LogInWithEmailAndPasswordFailure(
            "No user found for the given email. Please register first.");
      case "wrong-password":
        return const LogInWithEmailAndPasswordFailure(
            "Incorrect password. Please try again.");
      case "invalid-email":
        return const LogInWithEmailAndPasswordFailure(
            "Email is not valid or badly formatted.");
      case "user-disabled":
        return const LogInWithEmailAndPasswordFailure(
            "This user has been disabled. Please contact support for help.");
      case "too-many-requests":
        return const LogInWithEmailAndPasswordFailure(
            "Too many logIn attempts. Please try again later.");
      case "operation-not-allowed":
        return const LogInWithEmailAndPasswordFailure(
            "Operation not allowed. Please contact support.");
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }
}
