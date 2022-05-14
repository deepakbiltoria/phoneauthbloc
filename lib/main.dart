import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phoneauthbloc/screens/signin_screen.dart';

import 'cubit/phone_auth_bloc_cubit.dart';
import 'screens/home_screen.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneAuthBlocCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<PhoneAuthBlocCubit, PhoneAuthBlocState>(
          buildWhen: (oldState, newState) {
            return oldState is PhoneAuthBlocInitial;
          },
          builder: (context, state) {
            if (state is PhoneAuthLoggedInState) {
              return HomeScreen();
            } else if (state is PhoneAuthLoggedOutState) {
              return SignInScreen();
            } else {
              return Scaffold(
                body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'when initial state isnt loggedinstate or loggedoutstate either',
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        //CupertinoButton(
                        // child: Text('Log Out'), onPressed: () {})
                      ],
                    )),
              );
            }
          },
        ),
      ),
    );
  }
}
