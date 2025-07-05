import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/constants/colors_constants.dart';
import 'package:newsapp/constants/images_constants.dart';
import 'package:newsapp/presentation/widgets/simple_text.dart';
import '../../../constants/common_model/text_span_model.dart';
import '../../widgets/rich_text.dart';
import '../../widgets/text_common.dart';
import '../account/component/option_component.dart';
import '../setting/component/common_app_bar_component.dart';

class SelectedSubscriptionScreen extends StatefulWidget {
  final String planName;
  final String description;
  final String amount;
  final String percentage;

  const SelectedSubscriptionScreen({super.key, required this.planName, required this.description, required this.amount, required this.percentage});

  @override
  State<SelectedSubscriptionScreen> createState() => _SelectedSubscriptionScreenState();
}

class _SelectedSubscriptionScreenState extends State<SelectedSubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SizedBox(
        height: mediaHeight,
        width: mediaWidth,
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                left: 0,right: 0,
                child: SvgPicture.asset(ImagesConstants.appImageOne),),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CommonAppBarComponent(title: "Payment",),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 19),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 20,bottom: 20),
                              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                              decoration: BoxDecoration(
                                  color:ColorsConstants.appColor,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: ColorsConstants.textGrayColorLightThree)
                              ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: TextAll(align: TextAlign.start,
                                            text: widget.planName, weight: FontWeight.w500, color:ColorsConstants.white, max: 14)),
                                    Container(
                                        decoration: BoxDecoration(
                                            color: ColorsConstants.white ,
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                          child: TextAll(text: widget.percentage, weight: FontWeight.w500, color:ColorsConstants.appColor, max: 14),
                                        ))
                                  ],
                                ),
                                RichTextComponent2(
                                    list:[
                                      TextSpanModel(
                                          title: widget.amount,style:
                                      GoogleFonts.crimsonText(
                                          color:ColorsConstants.white,fontWeight: FontWeight.w700,
                                          fontSize: 40)
                                      ),
                                      TextSpanModel(title: "/Month",style:
                                      GoogleFonts.crimsonText(color:ColorsConstants.white,
                                          fontWeight: FontWeight.w700,fontSize: 20))]),

                                RichTextComponent2(
                                    list:[TextSpanModel(
                                        title: widget.description,style:
                                    GoogleFonts.poppins(
                                        color:ColorsConstants.white,fontWeight: FontWeight.w400,
                                        fontSize: 12)
                                    ),
                                      // TextSpanModel(
                                      //     title: " 2 users",style:
                                      // GoogleFonts.poppins(color:ColorsConstants.white,
                                      //     fontWeight: FontWeight.w400,fontSize: 12))
                                    ]),


                              ],),),
                            SimpleText(
                              text: "Choose your Payment option!",
                              style: GoogleFonts.crimsonText(
                                  fontSize: 20,fontWeight: FontWeight.w700),),
                            OptionComponent(
                                containerMargin: const EdgeInsets.symmetric(vertical: 10),
                                containerPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                showContainer: true,
                                pngImage: ImagesConstants.creditCard,
                                optionTitle: "Debit/Credit Card",
                                onTap:(){
                                  Map map = {
                                    'type' : "Debit/Credit Card",
                                    'image' : ImagesConstants.creditCard
                                  };
                                  Navigator.pushNamed(context, "/paymentScreen",arguments: map);
                                }
                            ),
                            OptionComponent(
                                containerMargin: const EdgeInsets.only(bottom: 10),
                                containerPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                showContainer: true,
                                pngImage: ImagesConstants.bank,
                                optionTitle: "Net Banking",
                                onTap:(){
                                  Map map = {
                                    'type' : "Net Banking",
                                    'image' : ImagesConstants.bank
                                  };
                                  Navigator.pushNamed(context, "/paymentScreen",arguments: map);
                                }
                            ),
                            OptionComponent(
                                containerMargin: const EdgeInsets.only(bottom: 10),
                                containerPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                showContainer: true,
                                pngImage: ImagesConstants.upi,
                                optionTitle: "UPI Payment",
                                onTap:(){
                                  Map map = {
                                    'type' : "UPI Payment",
                                    'image' : ImagesConstants.upi
                                  };
                                  Navigator.pushNamed(context, "/paymentScreen",arguments: map);
                                }
                            ),
                            OptionComponent(
                                containerMargin: const EdgeInsets.only(bottom: 10),
                                containerPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                showContainer: true,
                                pngImage: ImagesConstants.phonePay,
                                optionTitle: "Phone Pay",
                                onTap:(){
                                  Map map = {
                                  'type' : "Phone Pay",
                                  'image' : ImagesConstants.phonePay
                                };
                                  Navigator.pushNamed(context, "/paymentScreen",arguments: map);
                                }
                            ),
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
