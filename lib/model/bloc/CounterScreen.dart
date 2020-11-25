import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/bloc/CounterBlocState.dart';
import 'package:flutter_app/model/bloc/Counterbloc.dart';
import 'package:flutter_app/model/bloc/counterblocevent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {

  //Used to add events in to Bloc
  CounterBloc _counterBlocSink;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    //Close the Stream Sink when the widget is disposed
    _counterBlocSink?.close();
  }

  @override
  Widget build(BuildContext context) {

    //Initializing Bloc Sink by using BlocProvider
    _counterBlocSink = BlocProvider.of<CounterBloc>(context);

    return BlocProvider<CounterBloc>(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Counter App"),
          ),
          body: Container(
              width: double.infinity,
              child: BlocBuilder<CounterBloc, CounterBlocState>(
                builder: (context, state){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("You have clicked ${(state as LatestCounterState).newCounterValue} Times"),
                      SizedBox(height: 16,),
                      FlatButton(
                        child: Text("Increase Counter"),
                        onPressed: (){

                          //Send Decrease Counter EVent to the Bloc
                          _counterBlocSink.add(IncreaseCounterEvent());
                        },
                        color: Colors.redAccent,
                        textColor: Colors.white,
                      ),
                      SizedBox(height: 16,),
                      FlatButton(
                        child: Text("Decrease Counter"),
                        onPressed: (){

                          //Send Decrease Counter EVent to the Bloc
                          _counterBlocSink.add(DecreaseCounterEvent());
                        },
                        color: Colors.blue,
                        textColor: Colors.white,
                      ),
                    ],
                  );
                },
              )
          )
      ),
    );
  }
}
