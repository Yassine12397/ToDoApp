import 'package:bmi_ca/shared/compenents/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.login
        ),
        title: Text('Login',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
            ),
        actions: [
          Icon(
            Icons.list
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Form(
            key: formkey,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Login'
              ),
              SizedBox(height: 40.0
              ),
              defaultFormField
                (
                  type: TextInputType.emailAddress,
                label: 'Email address',
                prefix: Icons.email,
                validate: (String ?value)
                {
                  if(value!.isEmpty)
                    {
                      return 'email must not be empty';
                    }
                  return null;
                },
                controller: emailController,




              ),
              SizedBox(height: 15.0
              ),
              defaultFormField(
                  controller: passwordController,
                  prefix: Icons.lock,
                  validate: (String? value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'The password must not be empty';
                    }
                    return null;
                  },
                  type: TextInputType.visiblePassword,
                  label: 'Password'

              ),
              SizedBox(height: 20.0
              ),
              defaultButton(
                  function: ()
                  {
                    if(formkey.currentState!.validate())
                      {
                        print(emailController.text);
                        print(passwordController.text);
                      }
                  },
                text:'Login',

              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t you have an account ?',
                  ),
                  TextButton(
                    onPressed: ()
                      {

                      }, child: Text('Register Now'
                  ),
                  )
                ],
              ),


            ],
            ),
          ),
        ),
      ),

    );
  }
}
