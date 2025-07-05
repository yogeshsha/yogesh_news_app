import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/presentation/screens/setting/component/common_app_bar_component.dart';
import 'package:newsapp/presentation/widgets/primary_button_component.dart';
import 'package:newsapp/presentation/widgets/text_form_field.dart';
import '../../../constants/colors_constants.dart';
import '../../../constants/images_constants.dart';
import '../../widgets/simple_text.dart';
import '../../widgets/text_common.dart';

class PaymentScreen extends StatefulWidget {
  final String paymentType;
  final String image;
  const PaymentScreen({super.key, required this.paymentType, required this.image});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorsConstants.white,
      body: SizedBox(
        height: mediaHeight,
        width: mediaWidth,
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                right: 0,left: 0,
                  child: SvgPicture.asset(ImagesConstants.appImageOne)),
              // Positioned(
              //     left: 0,right: 0,top: 23,
              //     child: TextAll(text: "Payment", weight: FontWeight.w700, color: ColorsConstants.black, max: 20)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CommonAppBarComponent(title: "Payment"),
                  // const ArrowBackButton(),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 30),
                            SimpleText(
                              text: widget.paymentType,
                              style: GoogleFonts.crimsonText(
                                  fontSize: 20,fontWeight: FontWeight.w700),),
                            const SizedBox(height: 30),

                            TextAll(text: "Card Number", weight: FontWeight.w500,color: ColorsConstants.black, max: 12),
                            TextFormFieldWidget(
                              margin: const EdgeInsets.only(top: 5,bottom: 20),
                              borderCurve: 10,
                              controller: cardNumberController,
                              hint: "XXX XXX XXX XXX",
                              validation: (value){
                                if(value.trim().isEmpty){
                                  return "Enter Card Number";
                                }
                                return null;
                              },
                              suffix: SizedBox(
                                width: 10,
                                  child: Image.asset(widget.image)),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextAll(text: "Expiry Date", weight: FontWeight.w500,color: ColorsConstants.black, max: 12),
                                        TextFormFieldWidget(
                                          margin: const EdgeInsets.only(top: 5,),
                                          borderCurve: 10,
                                          controller: dateController,
                                          hint: "XX / XX" ,
                                          validation: (value){
                                            if(value.trim().isEmpty){
                                              return "Enter Date";
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: mediaWidth*.08,),
                                Expanded(
                                  child: SizedBox(
                                      child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextAll(text: "CVV", weight: FontWeight.w500,color: ColorsConstants.black, max: 12),
                                        SizedBox(
                                          child: TextFormFieldWidget(
                                            margin: const EdgeInsets.only(top: 5,),
                                            borderCurve: 10,
                                            controller: cvvController,
                                            maxLength: 3,
                                            hint: "***",
                                            hide: true,
                                            type: TextInputType.visiblePassword,
                                            validation: (value){
                                              if(value.trim().isEmpty){
                                                return "Enter CVV Number";
                                              }
                                              return null;
                                            }
                                          ),
                                        ),
                                      ],),
                                    ),
                                ),
                                SizedBox(width: mediaWidth*.10,),
                              ],
                            ),
                            PrimaryButtonComponent(
                              margin: const EdgeInsets.only(top: 50),
                                title: "Confirm Payment",
                                onTap:(){})
                          ],
                        ),
                      ),
                    ),
                  ),


                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
