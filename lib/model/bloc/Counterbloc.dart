
import 'package:flutter_app/model/bloc/CounterBlocState.dart';
import 'package:flutter_app/model/bloc/counterblocevent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterBlocEvent, CounterBlocState>{
  CounterBloc(CounterBlocState initialState) : super(initialState);



  //Set Initial State of Counter Bloc by return the LatestCounterState Object with newCounterValue = 0
  @override
  // TODO: implement initialState
  CounterBlocState get initialState => LatestCounterState(newCounterValue: 0);

  @override
  Stream<CounterBlocState> mapEventToState(CounterBlocEvent event) async*{

    // TODO: implement mapEventToState
    if(event is IncreaseCounterEvent){

      //Fetching Current Counter Value From Current State
      int currentCounterValue = (state as LatestCounterState).newCounterValue;

      //Applying business Logic
      int newCounterValue = currentCounterValue + 1;

      //Adding new state to the Stream, yield is used to add state to the stream
      yield LatestCounterState(newCounterValue: newCounterValue);

    }else if(event is DecreaseCounterEvent){

      //Fetching Current Counter Value From Current State
      int currentCounterValue = (state as LatestCounterState).newCounterValue;

      //Applying business Logic
      int newCounterValue = currentCounterValue - 1;

      //Adding new state to the Stream, yield is used to add state to the stream
      yield LatestCounterState(newCounterValue: newCounterValue);

    }

  }

}

