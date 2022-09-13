import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../auth/otp.dart';
import '../widgets/primary_button.dart';
import 'package:get/get.dart';
import 'dashboard.dart';
import 'login.dart';
import 'package:http/http.dart'as http;
class Register extends StatelessWidget {
  late String username;
  late String password;
  late String name;
  late String phone;
  late String email;
  show(messg)  {





  }
  Future userLogin() async {


    //Login API URL
    //use your local IP address instead of localhost or use Web API

      try {
       String url = "https://ahla-alamirat.com/RSG/API/signin.php?name=" +
           name + "&uname=" + username + "&pass=" + password;
      //  String url = "https://ahla-alamirat.com/RSG/API/signin.php?name=adnan&uname=ad&pass=;
         // Showing LinearProgressIndicator.


        // Getting username and password from Controller


        //Starting Web API Call.
        var response = await http.get(
            Uri.parse(url));
        if (response.statusCode == 200) {
          //Server response into variable

          var msg = jsonDecode(response.body);

          //Check Login Status
          if (msg['loginStatus'] == true) {
            Get.to(LOGIN());
            // Navigate to Home Screen
            //  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(uname:msg['userInfo']['NAME'])));
          } else {
            //Show Error Message Dialog
            show(msg["message"]);
          }
        } else {
          show("error");
        }
      }
      catch(error)
      {
        show("error");
      }


  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;





    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.login,
            color: Color.fromRGBO(33, 45, 82, 1),
          ),
        ),
        title: Text(
          "طلب انشاء حساب",
          style: TextStyle(
            color: Color.fromRGBO(33, 45, 82, 1),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Builder(builder: (BuildContext context) {
          return Container(
            height: _size.height ,
               //Body height removing appbar height
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Wrap(
                  runAlignment: WrapAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 30.0),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text(
                            "انشاء حساب",
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Color.fromRGBO(33, 45, 82, 1),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          //Leta take the form to a new page
                        Container(
                    child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                      Text(

                    "لاســم",
                    textAlign: TextAlign.right,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: ScreenUtil().setHeight(59.0),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(247, 247, 249, 1),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: TextFormField(

                        onChanged: (String value) { name=value;} ,

                        obscureText:false,
                        decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: TextStyle(
                            fontSize: 14.0,
                            color: Color.fromRGBO(124, 124, 124, 1),
                            fontWeight: FontWeight.w600,
                          ),
                          suffixIcon:  Icon(
                            Icons.person,
                            color: Color.fromRGBO(105, 108, 121, 1),
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //////////////
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "  الايميل   ",
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: ScreenUtil().setHeight(59.0),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(247, 247, 249, 1),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 24.0),
                          child: TextFormField(

                            onChanged: (String value) { email=value;} ,
                            keyboardType: TextInputType.emailAddress,
                            obscureText:false,
                            decoration: InputDecoration(
                              hintText: "ُEmail",
                              hintStyle: TextStyle(
                                fontSize: 14.0,
                                color: Color.fromRGBO(124, 124, 124, 1),
                                fontWeight: FontWeight.w600,
                              ),
                              suffixIcon:  Icon(
                                Icons.lock,
                                color: Color.fromRGBO(105, 108, 121, 1),
                              ),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ),


          //////////////////////////
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "رقم الهاتف ",
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: ScreenUtil().setHeight(59.0),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(247, 247, 249, 1),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 24.0),
                          child: TextFormField(
                            onChanged: (String value) { phone=value;} ,
                            validator: (String? value) {
                              return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                            },
                            maxLength: 9,
                            keyboardType: TextInputType.number,
                            obscureText:false,
                            decoration: InputDecoration(
                              hintText: "Phone",
                              hintStyle: TextStyle(
                                fontSize: 14.0,
                                color: Color.fromRGBO(124, 124, 124, 1),
                                fontWeight: FontWeight.w600,
                              ),
                              suffixIcon:  Icon(
                                Icons.phone_android_rounded,
                                color: Color.fromRGBO(105, 108, 121, 1),
                              ),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ),



                    SizedBox(height: 10.0),
                    Text(
                      "اسم  المستخدم",
                      textAlign: TextAlign.right,

                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: ScreenUtil().setHeight(59.0),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(247, 247, 249, 1),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: TextFormField(

                        onChanged: (String value) { username=value;} ,

                        obscureText:false,
                        decoration: InputDecoration(
                          hintText: "  Username",
                          hintStyle: TextStyle(
                            fontSize: 14.0,
                            color: Color.fromRGBO(124, 124, 124, 1),
                            fontWeight: FontWeight.w600,
                          ),
                          suffixIcon:  Icon(
                            Icons.lock,
                            color: Color.fromRGBO(105, 108, 121, 1),
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "  كلمة المرور",
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: ScreenUtil().setHeight(59.0),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(247, 247, 249, 1),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: TextFormField(

                        onChanged: (String value) { password=value;} ,

                        obscureText:false,
                        decoration: InputDecoration(
                          hintText: "password",
                          hintStyle: TextStyle(
                            fontSize: 14.0,
                            color: Color.fromRGBO(124, 124, 124, 1),
                            fontWeight: FontWeight.w600,
                          ),
                          suffixIcon:  Icon(
                            Icons.lock,
                            color: Color.fromRGBO(105, 108, 121, 1),
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                      ],
            ),
          )),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                PrimaryButton(
                  text: "تسجيل",
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OTPScreen(phone,name,password,username,email)));
               //     userLogin();

                  },
                ),
                Center(
                  child: Wrap(
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                          "هل تمتلك حساب ?",

                      ),
                      TextButton(
                        onPressed: () {
              //            Navigator.of((context)).push(mat)
                          Get.to(LOGIN());
                        },
                        child: Text(
                          "الدخول",

                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset("assets/images/google.png"),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset("assets/images/facebook.png"),
                    ),
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
