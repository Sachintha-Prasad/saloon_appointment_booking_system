class SBRegEx {
  SBRegEx._();

  static RegExp mobileNoRegEx = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
  static RegExp emailRegEx = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
}