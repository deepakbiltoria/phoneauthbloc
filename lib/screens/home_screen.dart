import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phoneauthbloc/cubit/phone_auth_bloc_cubit.dart';
import 'package:phoneauthbloc/screens/signin_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOME'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Screen for loggedinstate',
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              BlocConsumer<PhoneAuthBlocCubit, PhoneAuthBlocState>(
                listener: (context, state) {
                  if (state is PhoneAuthLoggedOutState) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => SignInScreen()),
                        (route) => false);
                  }
                },
                builder: (context, state) {
                  return CupertinoButton(
                      child: Text(
                        'Log Out',
                        style: TextStyle(fontSize: 30.0),
                      ),
                      onPressed: () {
                        BlocProvider.of<PhoneAuthBlocCubit>(context).logOut();
                      });
                },
              )
            ],
          )),
    );
  }
}
