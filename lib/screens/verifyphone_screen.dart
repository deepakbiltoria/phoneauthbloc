import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phoneauthbloc/cubit/phone_auth_bloc_cubit.dart';
import 'package:phoneauthbloc/cubit/phone_auth_bloc_cubit.dart';

import 'home_screen.dart';

class VerifyPhoneNumberScreen extends StatelessWidget {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Verify Phone Number'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              TextField(
                controller: otpController,
                maxLength: 6,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  counterText: ' ',
                  hintText: 'Enter 6 digit OTP',
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              BlocConsumer<PhoneAuthBlocCubit, PhoneAuthBlocState>(
                listener: (context, state) {
                  if (state is PhoneAuthLoggedInState) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen(),
                      ),
                      (route) => false,
                    );
                  } else if (state is PhoneAuthErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.errorMessage),
                      backgroundColor: Colors.red,
                      duration: Duration(milliseconds: 600),
                    ));
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
                      child: Text('Verify'),
                      onPressed: () {
                        String otpCode = otpController.text;
                        BlocProvider.of<PhoneAuthBlocCubit>(context)
                            .verifyOTP(otpCode);
                      },
                      color: Colors.blue,
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
