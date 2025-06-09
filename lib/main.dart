import 'package:flutter/material.dart';
import 'OtherPage.dart';

import 'DataRepository.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(  //constuctor for your entire application
      title: 'Flutter Demo',
      theme: ThemeData( colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),),
//      home:  OtherPage( ), //remove this for Named Routes
      initialRoute: '/', //default load the '/' route
      routes:  {
        '/'           :  (context) =>   MyHomePage(title:'Title')  ,
        '/secondPage' : (context) => OtherPage()
      } //  {  } is a map
    );
  }

}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _counter = 0;
  late TextEditingController _controller; //this is to read what was typed



  var isChecked = false;

  @override
  void initState() { //similar to onloaded=
    super.initState();

    _controller = TextEditingController(); //making _controller
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose(); // free the memory of what was typed
  }

  void _incrementCounter() {
    setState(() {
      if(_counter<99.0)
        _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Welcome to CST2335',  style:TextStyle(letterSpacing: 5.0,fontSize: 30.0, color:Colors.blue ) ),
            Text('$_counter',  style: Theme.of(context).textTheme.headlineMedium,),

            Semantics(child: Image.asset("images/algonquin.jpg", width: 200,height:200),
              label:"This is an image of Algonquin college"   ),

            ElevatedButton( onPressed: () {


              DataRepository.loginName = _controller.value.text;

              Navigator.pushNamed(context, '/secondPage');

            },  //<-----lambda function
                child:  Image.asset("images/algonquin.jpg", width: 200, height:200)  ),

            Checkbox(value: isChecked,
                onChanged: ( newVal ) {
                if(newVal != null)
                  setState(() {//update the GUI
                    isChecked = newVal; //store the new value
                  });
                }),
            Switch(value:isChecked,
              onChanged: (newVal){
                  if(newVal!= null)
                    setState(() {
                      isChecked = newVal;
                    });
              }),

            Row(children:[
          Flexible(child:    TextField(controller: _controller,
                decoration: InputDecoration(
                    hintText:"Type here",
                    border: OutlineInputBorder(),
                    labelText: "First name"
                ))
            ),
            IconButton(onPressed: () {  }, icon: Icon(Icons.phone))
            ]),
          ],
        ),
      ),

    );
  }

  void setNewValue(double value)
  {
    setState(() {
      _counter = value;
    }); //update the GUI to new values
  }


  void buttonClicked(){

  }
}
