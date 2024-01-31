String? emailValidation(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field can\'t be empty';
  } else if (!(RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value))) {
    return 'Enter Correct Email';
  } else {
    return null;
  }
}

String? passwordValidation(String? value) {
  if (value == null ||
      value.isEmpty ||
      !(RegExp(
              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{7,}.+$')
          .hasMatch(value))) {
    return '''${RegExp(r'^.{7,}.+$').hasMatch(value.toString()) ? '\u{2705}' : ' \u{02713}'} 8 Character Long.
${RegExp(r'^(?=.*?[A-Z]).+$').hasMatch(value.toString()) ? '\u{2705}' : ' \u{02713}'} 1 Upper Case.
${RegExp(r'^(?=.*?[a-z]).+$').hasMatch(value.toString()) ? '\u{2705}' : ' \u{02713}'} 1 Lower Case.
${RegExp(r'^(?=.*?[0-9]).+$').hasMatch(value.toString()) ? '\u{2705}' : ' \u{02713}'} 1 Digit.
${RegExp(r'^(?=.*?[!@#\$&*~]).+$').hasMatch(value.toString()) ? '\u{2705}' : ' \u{02713}'} 1 Spacial Character.''';
  } else {
    return null;
  }
}

String? confirmPasswordValidation(String? value, String passwordValue) {
  if (value == null || value.isEmpty) {
    return 'This field can\'t be empty';
  } else if (!(RegExp(r'^.{7,}.+$').hasMatch(value))) {
    return 'Password must be more than 7 characters';
  } else if (value != passwordValue) {
    return 'Password not match';
  } else {
    return null;
  }
}

String? dropDownFormFieldValidatorForCompanyField(String? value) {
  if (value == null || value.isEmpty || value == 'Select your company') {
    return 'Please Select your company';
  } else {
    return null;
  }
}

String? dropDownFormFieldValidatorForPostField(String? value) {
  if (value == null || value.isEmpty || value == 'Select Post') {
    return 'Please Select Post Of Employee';
  } else {
    return null;
  }
}

String? dropDownFormFieldValidatorBranchField(String? value) {
  if (value == null || value.isEmpty || value == 'Select Branch') {
    return 'Please Select Branch';
  } else {
    return null;
  }
}

String? simpleFieldValidation(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field can\'t be empty';
  } else {
    return null;
  }
}

String? companyNameValidation(String? value, List listOfCompaniesDocs) {
  if (value == null || value.isEmpty) {
    return 'This field can\'t be empty';
  } else if (listOfCompaniesDocs.isNotEmpty) {
    for (var doc in listOfCompaniesDocs) {
      if (doc.id == value) {
        return 'Company Name Already Existed';
      }
    }
  }
  return null;
}

String? companyBranchesValidation(String? value, List branches) {
  if (value == null || value.isEmpty) {
    return 'This field can\'t be empty';
  } else if (branches.isNotEmpty) {
    for (var branch in branches) {
      if (branch.id == value) {
        return 'Branch Name Already Existed';
      }
    }
  }
  return null;
}

String? phoneValidation(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field can\'t be empty';
  } else if (value.length <= 4) {
    return 'This field can\'t be empty';
  } else if (value.length >= 4 && value.length < 14) {
    return 'Please Enter Correct Number';
  } else {
    return null;
  }
}
