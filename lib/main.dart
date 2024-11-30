import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newdatabase_addnote/appdatabase.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
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
  var titleController=TextEditingController();
  var descController=TextEditingController();

  late AppDatabase myDB;
  List<Map<String,dynamic>> arrNotes=[];

  @override
  void initState() {
    myDB=AppDatabase.db;

    // TODO: implement initState
    super.initState();
    showN();
  }

  void addN(String title,String desc)async{
    bool check =await myDB.addNote(title,desc);
    if(check){
      arrNotes=await myDB.fetchAllNotes();
      setState(() {

      });
    }
  }

  void showN()async{
    arrNotes=await myDB.fetchAllNotes();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: arrNotes.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(arrNotes[index]["title"],),
              subtitle: Text("${arrNotes[index]["desc"]}")
            );
          },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          showModalBottomSheet(
              context: context,
              builder: (context){
                return Container(
                  height: 400,
                  child: Column(
                    children: [
                      Text("Add Note",style: TextStyle(fontSize: 20),),
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          label: Text("Title"),
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(4) )
                        ),

                      ),
                      TextField(
                        controller: descController,
                        decoration: InputDecoration(
                            label: Text("Title"),
                            border: OutlineInputBorder(borderRadius:BorderRadius.circular(4) )
                      ),),
                      ElevatedButton(onPressed: (){
                        var title=titleController.text.toString();
                        var desc=descController.text.toString();
                        addN(title,desc);
                        titleController.clear();
                        descController.text="";
                        Navigator.pop(context);
                        setState(() {

                        });
                      }, child: Text("Add"))
                    ],
                  ),
                );
              }
          );
        },
        tooltip: "add Notes",
        child: Icon(Icons.add),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
