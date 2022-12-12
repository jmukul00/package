import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package/src/sign_in/verify_screen.dart';

import '../auth/auth_cubit.dart';
import '../auth/auth_state.dart';

class SignInMobile extends StatelessWidget {
  String name = "Phone Number" ;
  SignInMobile({Key? key, this.name = "Phone Number"}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            AuthCubit(),
        child: MaterialApp(
          home: BlocBuilder<AuthCubit,AuthState>(
            builder: (context, state){
              return SignInMob(name: name,);
            },
          ),
        )
    );
  }
}


class SignInMob extends StatelessWidget {
  String name;
  SignInMob({Key? key, this.name = ""});

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sign In with Phone"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextField(
                controller: phoneController,
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: name,
                    counterText: ""
                ),
              ),

              const SizedBox(height: 10,),

              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {

                  if(state is AuthCodeSentState) {
                    Navigator.push(context, CupertinoPageRoute(
                        builder: (context) => VerifyScreen()
                    ));
                  }

                },
                builder: (context, state) {

                  if(state is AuthLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CupertinoButton(
                      onPressed: () {
                        String phoneNumber = "+91" + phoneController.text;
                        BlocProvider.of<AuthCubit>(context).sendOTP(phoneNumber);
                      },
                      color: Colors.blue,
                      child: const Text("Sign In"),
                    ),
                  );

                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}