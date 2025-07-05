import 'package:flutter/material.dart';
import 'package:newsapp/constants/colors_constants.dart';
Widget arrowBack(BuildContext context){
  return Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
      color: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(50)
    ),
    padding: const EdgeInsets.only(left: 8),
    child: Center(
      // child: Icon(Icons.arrow_back_ios,size: 25,),
      child: IconButton(
        alignment: Alignment.center,
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 20,
        ),
        color: Colors.black,
        // color: Theme.of(context).textTheme.displayLarge!.color,
      ),
    ),
  );
}
Widget arrowBack2(BuildContext context){
  return Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(50)
    ),
    padding: const EdgeInsets.only(left: 8),
    child: Center(
      // child: Icon(Icons.arrow_back_ios,size: 25,),
      child: IconButton(
        alignment: Alignment.center,
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 23,
        ),
        color: ColorsConstants.appColor,
      ),
    ),
  );
}



class ArrowBackButton extends StatelessWidget {
  final Function? onTap;
  const ArrowBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 39,
      width: 39,
      decoration: BoxDecoration(
          color:
          Theme.of(context).colorScheme.onBackground,
          // ColorsConstants.arrowBackColor,
        shape: BoxShape.circle
      ),

      child: Center(
        child: IconButton(
          alignment: Alignment.center,
          onPressed: () {
            if(onTap != null){
              onTap!();
            }else{
              Navigator.pop(context);
            }
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
          ),
          color:           Theme.of(context).colorScheme.onPrimary,
          // color: Theme.of(context).textTheme.displayLarge!.color,
        ),
      ),
    );
  }
}
class ArrowBackButton2 extends StatelessWidget {
  final Function? onTap;
  const ArrowBackButton2({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 39,
      width: 39,
      decoration: const BoxDecoration(
          color: Colors.transparent,
        shape: BoxShape.circle
      ),

      child: Center(
        child: IconButton(
          alignment: Alignment.center,
          onPressed: () {
            if(onTap != null){
              onTap!();
            }else{
              Navigator.pop(context);
            }
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
          ),
          color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
          // color: Theme.of(context).textTheme.displayLarge!.color,
        ),
      ),
    );
  }
}
