import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phoneauthbloc/cubit/phone_auth_bloc_cubit.dart';

import 'verifyphone_screen.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Sign In With Phone',
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Phone Number',
                  counterText:
                      " "), // counterText is the counter of the digits mentioned in maxLenth parameter
            ),
            SizedBox(
              height: 10.0,
            ),
            BlocConsumer<PhoneAuthBlocCubit, PhoneAuthBlocState>(
              listener: (context, state) {
                if (state is PhoneAuthcodesentState) {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => VerifyPhoneNumberScreen(),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is PhoneAuthLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CupertinoButton(
                    color: Colors.blue,
                    child: Text('Sign In'),
                    onPressed: () {
                      String phoneNumber = "+91" + phoneController.text;

                      BlocProvider.of<PhoneAuthBlocCubit>(context)
                          .sendOTP(phoneNumber);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      )),
    );
  }
}
