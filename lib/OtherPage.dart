import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as Snackbar;
import 'package:my_flutter_labs/DataRepository.dart';
import 'package:url_launcher/url_launcher.dart'; //look an Android application


//import 'package:flutter/cupertino.dart'; //look an iPhone application

class OtherPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return OtherPageState();   // from below
  }  //setState() to update GUI
}


class OtherPageState extends State<OtherPage> {
  late String name  ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //retrieve what was sent:
    name =  DataRepository.loginName;
  }

  @override
  Widget build(BuildContext context) {
    //returns your Scaffold for the page
    return Scaffold(appBar:  AppBar(title: Text("Page 2"),) ,

        body:  Center(child:
        Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          Text("Welcome $name to page 2"),

            FilledButton(child:Text("Go back"),
              onPressed:() {

                Navigator.pop(context); //hide the page

              } ,),

          OutlinedButton(onPressed: () async {
           // launchUrl(  Uri(scheme:"https://www.algonquincollege.com") );
          var str = "sms:888 123 4567";
          var result = await canLaunch(str);   //returns Future, is asynchronous
           if(result)
             launch(str);

           },
              child: Text("Launch URL", style: TextStyle(fontSize: 40.0),))
        ],
        ))

    ); //Use a Scaffold to layout a page with an AppBar and main body region
  }
}