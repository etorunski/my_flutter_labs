import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /*
  String  getString( {  int a = 0, double b=0.0, bool c = false }){

    return "hello world";

  }*/

  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

    getSharedPreferences();

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
            const Text('welcome to week 4',  style:TextStyle(letterSpacing: 5.0,fontSize: 30.0, color:Colors.blue ) ),
            Text('$_counter',  style: Theme.of(context).textTheme.headlineMedium,),

            Semantics(child: Image.asset("images/algonquin.jpg", width: 200,height:200),
              label:"This is an image of Algonquin college"   ),

            ElevatedButton( onPressed: () {

                showDialog(context: context,
                    builder:(BuildContext ctx) {

                  return AlertDialog(
                    title:  Text("Question?"),
                    content: Text("Do you want to save this?"),
                    actions: [
                      ElevatedButton(onPressed: (){

                        //loads the encrypted data table
                        EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
                        prefs.setString("UserInput", _controller.value.text);  //encrypt and save the data, strings only!


                        Navigator.pop(ctx);    }, child: Text('Yes') ),

                      FilledButton(onPressed: (){
                        EncryptedSharedPreferences prefs = EncryptedSharedPreferences();

                        prefs.clear();//remove the data

                        Navigator.pop(ctx);    }, child: Text('No')),
                      OutlinedButton(onPressed: () { Navigator.pop(ctx);    }, child: Text('Later'))
                      
                    ],

                  );
                    }
                );

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
            TextField(controller: _controller,
                decoration: InputDecoration(
                    hintText:"Type here",
                    border: OutlineInputBorder(),
                    labelText: "First name"
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }


  void getSharedPreferences() async // this function has a thread in it
  {
   //write this:
    EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    var str = await prefs.getString("UserInput"); //returns a Future<String>, not string

      if(str != null)
        {
          _controller.text = str;
        }


      //Or you can write:, does not need async function
    prefs.getString("UserInput").then( (str) {   if(str != null) {  _controller.text = str; }   });
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
