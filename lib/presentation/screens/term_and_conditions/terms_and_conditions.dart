import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/presentation/widgets/arrow_back_ios.dart';
import 'package:newsapp/presentation/widgets/stick_logo.dart';

import '../../../data/terms_and_condition_data/terms_bloc/terms_bloc.dart';
class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});
  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,

      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor ,
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
                logo()
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<TermsBloc, TermsState>(
            builder: (context, state) {
              if (state is TermsLoaded) {
              }
              return Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                child: Text("These Terms will be governed by and interpreted in accordance with the laws of the State of Country, and you submit to the non-exclusive jurisdiction of the state and federal courts located in Country for the resolution of any disputes.\nYou hereby indemnify to the fullest extent Company Name from and against any and/or all liabilities, costs, demands, causes of action, damages and expenses arising in any way related to your breach of any of the provisions of these Terms.",style: TextStyle(color: Theme.of(context).textTheme.displayLarge!.color),),
              ) ;
            }),
      ),
    );
  }
}
