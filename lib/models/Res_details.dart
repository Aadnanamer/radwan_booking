import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'Reserved.dart';


class CompanyDetails extends StatelessWidget {
  final Reserved companyInfo;
  CompanyDetails(this.companyInfo);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl, child:  Container(

      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25)
          )
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 5,
                  width: 60,
                  color: Colors.grey,
                ),
              ),
            ),

            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        child:Image.asset("assets/images/logo.png"),
                      ),
                      SizedBox(width: 20),
                      Text(
                        companyInfo.ID, style: TextStyle(
                          fontSize: 16
                      ),
                      ),

                    ],

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.bookmark_border_outlined, size: 30),
                      SizedBox(width: 10),
                      Icon(Icons.more_horiz_outlined, size: 30)

                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
                height: 30
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(companyInfo.DATE_FROM+"<....>"+companyInfo.DATE_TO, style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold
              ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 25, color: Colors.yellow),
                    SizedBox(width: 10),
                    Text(companyInfo.ID_APARTMENT)

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(Icons.timer, size: 25, color: Colors.yellow),
                      SizedBox(width: 10),
                      Text(companyInfo.STATE)

                    ],
                  ),

                ),

              ],
            ),
            SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Requirement', style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16
              ),
              ),
            ),
            // ...spread operator

            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 25),
                width: double.infinity,
                height: 40,

                child: ElevatedButton(
                  onPressed: (){

                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                  child: Text('Apply Now'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,),
              child: Container(

                width: double.infinity,
                height: 40,

                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                  child: Text('الـغـــاء'),
                ),
              ),
            ),
          ],
        ),


      ),
    ),);

  }
}
