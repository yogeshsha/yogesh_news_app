import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/presentation/widgets/elevated_button.dart';

import '../../../data/complain_data/complain_bloc/complain_bloc.dart';
import '../../../utils/app_localization.dart';
import '../../widgets/arrow_back_ios.dart';

class ComplainScreen extends StatefulWidget {
  const ComplainScreen({super.key});

  @override
  State<ComplainScreen> createState() => _ComplainScreenState();
}

class _ComplainScreenState extends State<ComplainScreen> {
  // TextEditingController complainController = TextEditingController();
  String complainController = "";

  void _submitComplaint() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            AppLocalizations.of(context)!.translate('Complaint Submitted'),
            style: TextStyle(
                color: Theme.of(context).textTheme.displayLarge!.color),
          ),
          content: Text(
            AppLocalizations.of(context)!.translate('Thank you for your feedback!'),
            style: TextStyle(
                color: Theme.of(context).textTheme.displayLarge!.color),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                AppLocalizations.of(context)!.translate('OK'),
                style: TextStyle(
                    color: Theme.of(context).textTheme.displayLarge!.color),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: arrowBack(context),
                ),
                Text(
                  AppLocalizations.of(context)!.translate('News Complaint'),
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).textTheme.displayLarge!.color),
                ),
                const SizedBox()
                // logo(animationController)
              ],
            ),
          )
        ],
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          AppLocalizations.of(context)!.translate('Subscription Page'),
          style:
              TextStyle(color: Theme.of(context).textTheme.displayLarge!.color),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<ComplainBloc, ComplainState>(builder: (context, state) {
          if (state is ComplainLoaded) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              _submitComplaint();
            });
          }else if(state is ComplainError){
            SchedulerBinding.instance.addPostFrameCallback((_) {

            });
          }else if(state is ComplainLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.translate('Please provide your complaint or feedback:'),
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Theme.of(context).textTheme.displayLarge!.color),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    maxLines: 7,
                    onChanged: (value){
                      setState(() {
                        complainController = value;
                      });
                    },
                    style: TextStyle(
                        color: Theme.of(context).textTheme.displayLarge!.color),
                    decoration: InputDecoration(
                        hintText:
                        AppLocalizations.of(context)!.translate('Enter your complaint...'),

                        hintStyle: TextStyle(
                            color: Theme.of(context).textTheme.displayLarge!.color),
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).textTheme.displayLarge!.color!,
                              width: 0.0),
                        )),
                  ),
                  const SizedBox(height: 16.0),
                  CustomElevatedButton(text: AppLocalizations.of(context)!.translate("Submit Complaint") , onPressed:  (){
                    // context.read<ComplainBloc>().add(
                    //     FetchComplain(complain: complainController.text.trim() ,id: SessionHelper().get(SessionHelper.USER_ID) ?? "" )
                    // );
                    complainController.isEmpty ? null :
                    _submitComplaint();
                  })

                ],
              ),
            );
        }),
      ),
    );
  }
}

