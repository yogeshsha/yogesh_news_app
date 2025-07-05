import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newsapp/presentation/widgets/simple_text.dart';
import '../../../constants/images_constants.dart';
import '../../widgets/primary_button_component.dart';

class ConnectionTimeoutScreen extends StatelessWidget {
  final bool isHome;

  const ConnectionTimeoutScreen({super.key, required this.isHome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                ImagesConstants.connectionTimeOutSvg,
                fit: BoxFit.fill,
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 45,vertical: 30),
                child: SimpleText(
                  text:
                "We Understand Your Frustration With Technical Issues. We Feel It Too",
                  size: 20,
                  alignment: TextAlign.center,
                  weight: FontWeight.w600
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: PrimaryButtonComponent(
                        title: "Home",
                        onTap: (){
                    
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/home", (route) => false);
                    
                        }),
                  ),
                  Expanded(
                    child: PrimaryButtonComponent(
                        title: "Retry",
                        onTap: () {
                          Navigator.pop(context);
                        }),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
