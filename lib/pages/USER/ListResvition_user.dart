import 'dart:convert';
import '../../models/Res_details.dart';
import '/models/Res_item.dart';
import '/widgets/tag_list.dart';
import 'package:flutter/material.dart';
import '/models/Reserved.dart';
import 'package:http/http.dart'as http;
import '/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ListPage extends StatefulWidget {
  ListPage({required Key key, required this.title}) : super(key: key);

  final String title;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late List ReservedList;
  String? _savedData=" ";
  lodeSaveData() async
  {

    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    if(sharedPreferences.getString("USER")!=null) {

      setState(() {
        _savedData = sharedPreferences.getString("ID").toString();
        ReservedShow();
      });

    }
    else
    {
      _savedData= "not vallue";


    }
    print("object"+_savedData.toString());
    return _savedData;
  }
  Future ReservedShow() async {


    String url =  Constants.URL+"ReservedUser.php?ID="+_savedData.toString();
    try { //Starting Web API Call.
      var response = await http.get(Uri.parse(url));


      if (response.statusCode == 200) {
        var msg = json.decode(response.body);
        {
          List<Reserved> users = [];


          for (var singleUser in msg) {
            users.add( Reserved(
                USER: singleUser['USERNAME'],
                STATE: (singleUser['STATE']=='1' ?  'موكد ' : 'غير موكد'),
                DATE_FROM: singleUser['DATE_FROM'],
                DATE_TO:singleUser['DATE_TO'],
                ID_APARTMENT:singleUser['NAME'],
                ID: singleUser['ID']));

          }
          setState(() {
            EasyLoading.dismiss();
            ReservedList=users;
          });
          //Navigator.pop(context);
        }

      }


    }
    catch(err)
    {
print("errorr");
    }
  }
  @override
  void initState() {

    ReservedList = getLessons();
    lodeSaveData();
    EasyLoading.instance.indicatorType=EasyLoadingIndicatorType.threeBounce;
    EasyLoading.show(  status: 'loading...',
      maskType: EasyLoadingMaskType.black,

    );


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile2(Reserved lesson) => ListTile(
      contentPadding:
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.black))),
        child: Icon(Icons.person, color: Colors.black),
      ),
      title: Text(
        lesson.USER,
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
      ),
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

      subtitle: Row(
        children: <Widget>[

          Expanded(
            flex: 4,
            child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(lesson.DATE_FROM,
                    style: TextStyle(color: Colors.green))),
          )
        ],
      ),
      trailing:
      Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),





    );

    /////////////////////////////////


    ListTile makeListTile(Reserved lesson) => ListTile(
      hoverColor: Constants.FontColor,

      contentPadding:
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading:Chip(
        padding: EdgeInsets.all(0),
        backgroundColor: Constants.primaryColor,
        label: Text(lesson.STATE, style: TextStyle(color: Constants.FontColor)),
      ),
      onTap: () {


      },

      title: Text(
        lesson.USER,
        textAlign: TextAlign.right,
        style: TextStyle(color: Constants.FontColor),

      ),
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

      subtitle:Container(
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Row(
                children: <Widget>[

                  Expanded(
                    flex: 4,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),

                        child: Text("تاريخ البداء ",    textAlign: TextAlign.right,
                            style: TextStyle(color: Constants.FontColor))),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),

                        child: Text("تاريخ الانتهاء ",    textAlign: TextAlign.right,
                            style: TextStyle(color: Constants.FontColor))),
                  ),

                ],),
              Row(
                children: <Widget>[

                  Expanded(
                    flex: 4,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),

                        child: Text("2022-12-11",
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Constants.FontColor))),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),

                        child: Text("2022-12-11",
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Constants.FontColor))),
                  ),

                ],),

            ],
          )),


      trailing:
      Container(
        padding: EdgeInsets.only(left: 12.0),

        child:Image.asset("assets/images/house1.png"),
        decoration: new BoxDecoration(
            border: new Border(
                left: new BorderSide(width: 1.0, color: Constants.primaryColor))),
      ),


    );











    ///////////////////











    Card makeCard(Reserved lesson) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: makeListTile(lesson),
      ),
    );
    Card makeCard2(Reserved lesson) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: makeListTile(lesson),
      ),
    );
    final makeBody = Container(
      margin: EdgeInsets.only(top: 60),
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child:
      Column(

         crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [

          TagList(),
          Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              height: 650,
              child:ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: ReservedList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: (){
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context)=>CompanyDetails(ReservedList[index]),
                    );
                  },

                  child: ReservationItem(ReservedList[index]));

            },
          )),

        ],
      )

    );

    final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.blur_on, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.hotel, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.account_box, color: Colors.white),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
    //////// APP
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color(0xFF445B5B),
      title: Text(widget.title,style:TextStyle(color: Color(0xFFe4c4a3)),),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {},
        )
      ],
    );

    return Scaffold(

      body:  Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(),

              ),
              Expanded(
                flex: 1,
                child: Container(
                    color: Colors.grey.withOpacity(0.1)
                ),

              ),
            ],
          ),
          makeBody

        ],
      ),

    );
  }
}

List getLessons() {
  return [

  ];
}