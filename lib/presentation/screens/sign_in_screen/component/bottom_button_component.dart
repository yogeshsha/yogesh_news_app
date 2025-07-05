import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/colors_constants.dart';
import '../../../widgets/elevated_button.dart';

class BottomButtonComponent extends StatelessWidget {
  final Function onTapLeft;
  final Function onTapRight;

  const BottomButtonComponent({
    super.key,
    required this.onTapLeft,
    required this.onTapRight});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)),
            color: Theme.of(context).colorScheme.onSecondaryContainer,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, spreadRadius: 10, blurRadius: 20)
            ]),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: CustomElevatedButton(
                  buttonColor: Theme.of(context).colorScheme.secondaryContainer,
                  style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w500,color: ColorsConstants.white),
                  onPressed: (){onTapLeft();},
                  text: "Back",
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: SizedBox(
                height: 50,
                child: CustomElevatedButton(
                    buttonColor: ColorsConstants.appColor,
                    style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w500,color: ColorsConstants.white),
                    text: "Save",
                    onPressed: () {onTapRight();}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
