import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/validation.dart';
import 'constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.validator,
    this.textInputAction,
    this.onChanged,
    this.maxLength,
    this.filled,
    this.fillColor,
    this.enableInteractiveSelection,
    this.focusNode,
    this.maxLines = 1,
    this.counterText,
  });

  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final bool enabled;
  final ValueChanged? onChanged;
  final int? maxLength;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;
  final bool? filled;
  final Color? fillColor;
  final bool? enableInteractiveSelection;
  final FocusNode? focusNode;
  final int? maxLines;
  final String? counterText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(smallPadding),
      child: TextFormField(
        focusNode: focusNode,
        autovalidateMode: AutovalidateMode.always,
        validator: validator,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        enabled: enabled,
        onChanged: onChanged,
        maxLength: maxLength,
        maxLines: maxLines,
        enableInteractiveSelection: enableInteractiveSelection,
        decoration: InputDecoration(
          isDense: true,
          counterText: counterText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          label: FittedBox(child: Text(hintText)),
          border: _border,
          enabledBorder: _border,
          focusedBorder: _border,
          filled: filled,
          fillColor: fillColor,
          errorMaxLines: 5,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(smallBorderRadius),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  get _border => OutlineInputBorder(
      borderRadius: BorderRadius.circular(smallBorderRadius));
}

class CustomDropdownButtonFormField extends StatelessWidget {
  const CustomDropdownButtonFormField(
      {super.key,
      required this.items,
      required this.onChanged,
      this.selected,
      required this.defaultHintValue,
      required this.dropDownFormFieldValidator,
      this.filled,
      this.onTab});

  final String defaultHintValue;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged onChanged;
  final String? selected;
  final String? Function(String? value) dropDownFormFieldValidator;
  final bool? filled;
  final Function()? onTab;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: smallPadding, vertical: smallestPadding),
      child: DropdownButtonFormField(
        autovalidateMode: AutovalidateMode.always,
        hint: DropdownMenuItem(
          value: defaultHintValue,
          child: Text(defaultHintValue, overflow: TextOverflow.ellipsis),
        ),
        onTap: onTab,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: filled,
          isDense: true,
          border: _border,
          enabledBorder: _border,
          focusedBorder: _border,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(smallBorderRadius),
              borderSide: const BorderSide(color: Colors.grey)),
        ),
        validator: dropDownFormFieldValidator,
        items: items,
        onChanged: onChanged,
        value: selected,
      ),
    );
  }

  get _border => OutlineInputBorder(
      borderRadius: BorderRadius.circular(smallBorderRadius));
}

Widget customLocationTextFields(
    {required TextEditingController latitudeController,
    required TextEditingController longitudeController,
    TextInputAction textInputAction = TextInputAction.next}) {
  return Row(
    children: [
      Expanded(
        child: CustomTextField(
          textInputAction: TextInputAction.next,
          prefixIcon: const Icon(CupertinoIcons.arrow_left_right),
          hintText: 'Latitude',
          controller: latitudeController,
          keyboardType: TextInputType.number,
          validator: simpleFieldValidation,
        ),
      ),
      Expanded(
        child: CustomTextField(
          textInputAction: textInputAction,
          prefixIcon: const Icon(CupertinoIcons.arrow_up_down),
          hintText: 'Longitude',
          controller: longitudeController,
          keyboardType: TextInputType.number,
          validator: simpleFieldValidation,
        ),
      ),
    ],
  );
}

class CustomEmailTextField extends StatelessWidget {
  const CustomEmailTextField(
      {super.key,
      required this.controller,
      this.title = 'Email',
      this.filled,
      this.focusNode});
  final TextEditingController controller;
  final String title;
  final bool? filled;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      focusNode: focusNode,
      textInputAction: TextInputAction.next,
      prefixIcon: const Icon(Icons.email_outlined),
      hintText: title,
      controller: controller,
      validator: emailValidation,
      keyboardType: TextInputType.emailAddress,
      fillColor: Colors.white,
      filled: filled,
    );
  }
}

class CustomPasswordTextField extends StatefulWidget {
  const CustomPasswordTextField({
    super.key,
    required this.controller,
    this.filled,
  });
  final TextEditingController controller;
  final bool? filled;
  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  late bool obscurePassword;
  @override
  void initState() {
    super.initState();
    obscurePassword = true;
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      textInputAction: TextInputAction.done,
      prefixIcon: const Icon(Icons.lock_outline),
      hintText: 'Password',
      controller: widget.controller,
      obscureText: obscurePassword,
      keyboardType: TextInputType.visiblePassword,
      fillColor: Colors.white,
      filled: widget.filled,
      enableInteractiveSelection: false,
      validator: passwordValidation,
      suffixIcon: IconButton(
        onPressed: () => setState(() => obscurePassword = !obscurePassword),
        icon: Icon(
          obscurePassword
              ? CupertinoIcons.eye_slash_fill
              : CupertinoIcons.eye_fill,
        ),
      ),
    );
  }
}

Widget customConfirmPasswordField(
    {required TextEditingController controller,
    required TextEditingController passwordController,
    bool? filled}) {
  bool obscurePassword = true;
  return StatefulBuilder(builder: (context, setState) {
    return CustomTextField(
      textInputAction: TextInputAction.done,
      prefixIcon: const Icon(Icons.lock_outline),
      hintText: 'Confirm Password',
      controller: controller,
      obscureText: obscurePassword,
      fillColor: Colors.white,
      filled: filled,
      keyboardType: TextInputType.visiblePassword,
      validator: (value) =>
          confirmPasswordValidation(value, passwordController.text),
      suffixIcon: IconButton(
        onPressed: () => setState(() => obscurePassword = !obscurePassword),
        icon: Icon(
          obscurePassword
              ? CupertinoIcons.eye_slash_fill
              : CupertinoIcons.eye_fill,
        ),
      ),
    );
  });
}

Widget customContactTextField(
    {required hintText,
    required TextEditingController controller,
    bool? filled}) {
  return CustomTextField(
    textInputAction: TextInputAction.next,
    keyboardType: TextInputType.number,
    maxLength: 14,
    counterText: '',
    prefixIcon: const Icon(Icons.phone_outlined),
    hintText: hintText,
    fillColor: Colors.white,
    filled: filled,
    controller: controller,
    validator: phoneValidation,
    onChanged: (value) {
      if (value.length <= 4) {
        controller.text = '+92 ';
      }
    },
  );
}

Widget customNameTextField(
    {required String hintText,
    required TextEditingController controller,
    icon = Icons.person}) {
  return CustomTextField(
    textInputAction: TextInputAction.next,
    prefixIcon: Icon(icon),
    hintText: hintText,
    validator: simpleFieldValidation,
    keyboardType: TextInputType.name,
    controller: controller,
  );
}
