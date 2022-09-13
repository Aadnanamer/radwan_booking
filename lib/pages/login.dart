import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/pages/tabs_screen.dart';
import 'USER/tabs_screen_user.dart';
import '/utils/constants.dart';
import '/widgets/primary_button.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
class User {
  final int id;
  final int userId;
  final String title;
  final String body;

  User({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });
}
class LOGIN extends StatefulWidget {
  const LOGIN({Key? key}) : super(key: key);

  @override
  State<LOGIN> createState() => _LOGINState();
}

class _LOGINState extends State<LOGIN> {

  late String username;
  late String password;
  late String _token;
  gettoken() async{
  String? token = await FirebaseMessaging.instance.getToken();
  print(token);
  setState(() {

  _token=token!;
  });

}
  //Textediting Controller for Username and Password Input
  late var userController = TextEditingController();
  late var pwdController = TextEditingController();
  bool _chickboxVal=false;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    String? _savedData=" ";

    Future<void> Keep(Key,Value) async {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      //final int counter = (prefs.getInt(msg) ?? 0) + 1;


      prefs.setString(Key, Value);
    }


    show(messg)  {

      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.danger,
              text:  messg
          )
      );

    }

    showLoaderDialog(BuildContext context){
      AlertDialog alert=AlertDialog(
        content: new Row(
          children: [
            CircularProgressIndicator(),
            Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
          ],),
      );
      showDialog(barrierDismissible: false,
        context:context,
        builder:(BuildContext context){
          return alert;
        },
      );
    }
    Future userLogin() async {
      showLoaderDialog(context);
      //Login API URL
      //use your local IP address instead of localhost or use Web API
      String url = Constants.URL+"log.php?uname="+username+"&pass="+password+"&token="+_token;

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
          Navigator.pop(context);
          Keep("USER",msg['userInfo']['NAME']);
          Keep("ID",msg['userInfo']['UID']);
          Keep("STATE",msg['userInfo']['STATE']);
          if(_chickboxVal) {
            Keep("Keep","true");
          }
          else
            {
              Keep("Keep","false");
            }

          if (msg['userInfo']['TYPE'].toString()=="0")
          {
           Get.to(TabScreenUser());
          }
          else
          {
          Get.to(TabScreen());
          }



          // Navigate to Home Screen
          //  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(uname:msg['userInfo']['NAME'])));
        } else {
          Navigator.pop(context);
          //Show Error Message Dialog
          show("تاكد من اسم المستخدم او كلمة المروار");

        }
      } else {
        Navigator.pop(context);
        show("تاكد من اسم المستخدم او كلمة المروار");
      }

    }



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
          "     تسجيل الدخول",
          style: TextStyle(
            color: Color.fromRGBO(33, 45, 82, 1),
          ),
        ),
      ),
      body: SingleChildScrollView(

        child: Builder(builder: (BuildContext context) {
          return
            Container(
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
                              "تسجل الدخول ",
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

                                        "الايميل",
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
                                            hintText: "username",
                                            hintStyle: TextStyle(
                                              fontSize: 14.0,
                                              color: Color.fromRGBO(124, 124, 124, 1),
                                              fontWeight: FontWeight.w600,
                                            ),
                                            suffixIcon:  Icon(
                                              Icons.person,
                                              color:Constants.primaryColor,
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
                                      ),     SizedBox(height: 10.0),
                                      Text(
                                        "كلمة المرور",
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
                                      ),         SizedBox(
                                        height: 10.0,
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
                  Center(child:
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
  Text(" حفظ كلمة المرور "),
  Checkbox(
      activeColor: Constants.FontColor,
      value: _chickboxVal, onChanged: (bool? values){

    if(values!=null)
    {
      setState(() => _chickboxVal=values);


    }
  }),
],)),
                  PrimaryButton(
                    text: "تسجيل",
                    onPressed: () {
                      userLogin();



                      //       fet();
//Get.to(Dashboard());
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
                            userLogin();
                            //    fet();

                            //            Navigator.of((context)).push(mat)
                            //   Get.to(Home());
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

                ],
              ),

            );
        }),
      ),

    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
    gettoken();
  }
}


