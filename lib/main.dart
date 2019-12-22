import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

void main() => runApp(MyApp());

class CounterBloc {
  int factor = 1;
  int counter = 0;
  static final instance = CounterBloc();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Injector(
        inject: [Inject(() => CounterBloc.instance)],
        builder: (_) => HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Injector.getAsReactive<CounterBloc>(
      context: context,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'States Rebuilder Counter',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Increment factor',
              ),
              textAlign: TextAlign.center,
              onChanged: (factor) => model.setState((state) {
                state.factor = (factor?.isNotEmpty ?? false) ?
                  int.parse(factor) : 1;
              }),
            ),
            Text(
              '${model.state.counter}',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model.setState((state) {
          state.counter += state.factor;
        }),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
