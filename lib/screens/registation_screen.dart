import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snote/models/model_class.dart';
import 'package:snote/repositories/database_connection.dart';
import 'package:snote/screens/login_screen.dart';
import 'package:snote/widgets/custom_text_field.dart';

class RegistationScreen extends StatefulWidget {
  const RegistationScreen({Key? key}) : super(key: key);

  @override
  _RegistationScreenState createState() => _RegistationScreenState();
}

class _RegistationScreenState extends State<RegistationScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  void checkValidation() {
    if (_formkey.currentState!.validate()) {
      var name = nameController.text.toString();
      var phone = phoneController.text.toString();
      var email = emailController.text.toString();
      var password = passController.text.toString();
      var id = 0;
      if (id == 0) {
        SQLHelper.insertDataUser(name, phone, email, password).then((value) => {
              if (value != -1)
                {
                  print("User data inserted Successfully"),
                  toastMessage('Login Successful')
                }
              else
                {print("Failed user data insert")}
            });
      } else
        toastMessage('Something Wrong');
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    }
  }

  void toastMessage(var toastText) {
    Fluttertoast.showToast(
        msg: toastText,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        backgroundColor: Colors.blue,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green[50],
        appBar: AppBar(
          backgroundColor: Colors.green[50],
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              checkValidation();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.green,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 30,
                    //color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Create a new account',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 120,
                ),
                CustomTextField(
                  controller: nameController,
                  label: Text('NAME'),
                  hintText: 'Enter your name',
                  prefixIcon: Icon(Icons.person),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                CustomTextField(
                  controller: phoneController,
                  label: Text('PHONE'),
                  hintText: 'Enter your number',
                  keyboardType: TextInputType.number,
                  prefixIcon: Icon(Icons.phone),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  label: Text('EMAIL'),
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.mail),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Email';
                    }if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return 'Please Enter Valid Email';
                      }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                CustomTextField(
                  controller: passController,
                  obscureText: true,
                  label: Text('PASSWORD'),
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.lock),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Password';
                    }
                    return value.length <= 6
                        ? 'Password must be six characters'
                        : null;
                  },
                ),
                SizedBox(height: 40),
                ModelClass.submitButton(
                    const Text(
                      'CREATE',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ), () {
                  checkValidation();
                  // var name = nameController.text.toString();
                  // var phone = phoneController.text.toString();
                  // var email = emailController.text.toString();
                  // var password = passController.text.toString();
                  // var id = 0;
                  // if (id == 0) {
                  //   SQLHelper.insertDataUser(name, phone, email, password)
                  //       .then((value) => {
                  //             if (value != -1)
                  //               {
                  //                 print("User data inserted Successfully"),
                  //               }
                  //             else
                  //               {print("Failed user data insert")}
                  //           });
                  // }
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => LoginScreen(),
                  //     ));
                }),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already Have a account?",style: TextStyle(fontSize: 18),),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                      child: Text("Login",style: TextStyle(fontSize: 18, color: Colors.green),),
                    ),
                    
                  ],
                )
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}