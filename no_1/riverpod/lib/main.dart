import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(ChangeNotifierProvider(
    create: (context) => Counter(),
    child: MainApp(),
    )
  );
}

class Counter extends ChangeNotifier{
  int _count = 0;

  int get count => _count;

  void increment(){
    _count++;
    notifyListeners();
  }
}

class MainApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Provider Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text ("Provider Demo"),
      ),
      body: Center(
        child: Consumer<Counter>(
          builder: (context, counter, child){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('You have pushed the button this many times:',
                  style: TextStyle(fontSize: 30.0)),
                Text('${counter.count}',
                  style: TextStyle(fontSize: 30.0)),
                ElevatedButton(
                  onPressed: () {
                    counter.increment();
                    print('Button pressed ${counter.count} times');},
                  child: Text('Increment', style: TextStyle(fontSize: 30.0)),
                )
              ],
            );
          },
        ),
      )
    );
  }
}
