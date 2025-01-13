class AuthHeaderData {
  final String title;
  final String subtitle;

  AuthHeaderData({required this.title, required this.subtitle});
}

// register page data
final registerHeaderData = AuthHeaderData(
  title: "Create an account,",
  subtitle: 'Please type full information below and we can create your account',
);

// login page data
final logInHeaderData = AuthHeaderData(
  title: "Welcome back,",
  subtitle: 'Glad to meet you again!, please login to use the app.',
);
