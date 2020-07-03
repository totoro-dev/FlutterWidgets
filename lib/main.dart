import 'package:flutter/material.dart';
import 'package:flutter_app/weight/DefaultRecyclerAdapter.dart';
import 'weight/RecyclerView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: '黄龙淼的Flutter RecyclerView测试'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  RecyclerView recyclerView = RecyclerView();
  DefaultRecyclerAdapter adapter = new DefaultRecyclerAdapter();

  void _incrementCounter() {
    setState(() {
      _counter ++;
      if(_counter % 8 == 0){
        adapter.clear();
      } else{
        adapter.addItem(_counter.toString());
      }
      adapter.notifyDataSetChanged();
    });
  }

  @override
  Widget build(BuildContext context) {
    recyclerView.setAdapter(adapter);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(child: Container(child: Text('Flutter RecyclerView',style: TextStyle(fontSize: 24.0),),margin: EdgeInsets.fromLTRB(100,20,100,20), )),
            recyclerView,
            Text(
              '$_counter',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
