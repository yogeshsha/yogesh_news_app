import 'package:flutter/material.dart';
import '../../../../utils/app_localization.dart';

class TextFieldLoginPage extends StatelessWidget {
  final TextEditingController controller;
  final Widget? suffixIcon;
  final IconData icon;
  final bool hideText;
  final String? Function(String?)? validation;
  final String hintText ;

  const TextFieldLoginPage(
      {super.key,
      required this.controller,
      required this.icon,
      this.hideText = false,
      required this.validation,
      this.suffixIcon,required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Theme.of(context).textTheme.displayLarge!.color),
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.translate(hintText),
        labelStyle:
            TextStyle(color: Theme.of(context).textTheme.displayLarge!.color),
        prefixIcon: Icon(
          icon,
          color: Theme.of(context).textTheme.displayLarge!.color,
        ),
        suffixIcon: suffixIcon,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintStyle:
            TextStyle(color: Theme.of(context).textTheme.displayLarge!.color),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Theme.of(context).textTheme.displayLarge!.color!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Theme.of(context).textTheme.displayLarge!.color!,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
      ),
      obscureText: hideText,
      validator: validation,
    );
  }
}

class RegisterText extends StatelessWidget {
  const RegisterText({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, "/signUp")
            .then((value) => Navigator.pop(context)),
        child: Padding(
          padding: const EdgeInsets.only(right: 10, top: 10),
          child: Text(
            AppLocalizations.of(context)!.translate("Register"),
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .color,
            ),
          ),
        ),
      ),
    );
  }
}

Widget tempSizeBoxHeight(){
  return const SizedBox(height: 20);
}