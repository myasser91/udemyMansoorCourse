import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger/shared/components/components.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailcontroller = TextEditingController();

  var passwordcontroller = TextEditingController();

  var formkey = GlobalKey<FormState>();

  bool ispasswordshow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sarah Pharmacy'),
            Icon(Icons.local_pharmacy_outlined),
          ],
        ),
        actions: [
          Container(
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.notification_important),
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.purple[300],
      ),
      body: Container(
        color: Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    defaultFormField(
                      onChange: () {},
                      labelText: 'email adress',
                      prefixIcon: Icons.mail,
                      type: TextInputType.emailAddress,
                      controller: emailcontroller,
                      validate: (String?value){
                        if(value!.isEmpty){
                          return 'must be entered';
                        }
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                        validate: (String?value){
                        if(value!.isEmpty){
                          return 'must be entered';
                        }
                      },
                      onChange: () {},
                      isPass: ispasswordshow,
                      labelText: 'PASSWORD',
                      suffixIcon: ispasswordshow
                          ? Icons.visibility
                          : Icons.visibility_off,
                      suffixpressed: () {
                        setState(() {
                          ispasswordshow = !ispasswordshow;
                        });
                      },
                      prefixIcon: Icons.lock,
                      controller: passwordcontroller,
                      type: TextInputType.visiblePassword,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    defaultButtom(
                        text: 'login',
                        onpress: () {
                          if (formkey.currentState?.validate() != null) {
                            print(emailcontroller.text);
                            print(passwordcontroller.text);
                          }
                        }),
                    SizedBox(
                      height: 5,
                    ),
                    defaultButtom(
                        text: 'reGister',
                        onpress: () {
                          if (formkey.currentState?.validate() != null) {
                            print(emailcontroller.text);
                            print(passwordcontroller.text);
                          }
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account?'),
                        TextButton(onPressed: () {}, child: Text('Sign Up')),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
