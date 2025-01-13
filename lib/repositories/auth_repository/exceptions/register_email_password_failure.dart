class RegisterWithEmailAndPasswordFailure {
  final String message;

  const RegisterWithEmailAndPasswordFailure([this.message = "An Unknown error occurred."]);

  factory RegisterWithEmailAndPasswordFailure.code(String code){
    switch(code){
      case "weak-password" :
        return const RegisterWithEmailAndPasswordFailure("Please enter a stronger password.");
      case "invalid-email" :
        return const RegisterWithEmailAndPasswordFailure("Email is not valid or badly formatted.");
      case "email-already-in-use" :
        return const RegisterWithEmailAndPasswordFailure("An account already exists for that email.");
      case "operation-not-allowed" :
        return const RegisterWithEmailAndPasswordFailure("Operation not allowed. Please contact support.");
      case "user-disabled" :
        return const RegisterWithEmailAndPasswordFailure("This user has been disabled. Please contact support for help.");
      default :
        return const RegisterWithEmailAndPasswordFailure();
    }
  }
}