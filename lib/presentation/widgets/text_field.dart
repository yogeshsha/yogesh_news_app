// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
Widget TextInputField(BuildContext context,String hint,TextEditingController controller,int lines,{Function(String?)? validation}) {
  return TextFormField(
    maxLines: null,
    controller: controller,
    expands: true,
    cursorColor: Theme.of(context).textTheme.displayLarge!.color,
    textInputAction: TextInputAction.done,
    validator: (value)=> validation!(value),
    textCapitalization: TextCapitalization.sentences,
    scrollPhysics: const BouncingScrollPhysics(),
    decoration: InputDecoration(
        hintText: hint,
        isCollapsed: true,

        isDense: true,
        hintStyle:  const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: Colors.grey
        ),
        contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        filled: false,
        fillColor: Colors.white,
        border: OutlineInputBorder(

          borderRadius: BorderRadius.circular(15),

        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(15)
        ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).textTheme.displayLarge!.color!
        ),
        borderRadius: BorderRadius.circular(15),
      )

    ),
    style: TextStyle(
      color: Theme.of(context).textTheme.displayLarge!.color,
      fontWeight: FontWeight.w300,
      fontSize: 18,
    ),
  );
}