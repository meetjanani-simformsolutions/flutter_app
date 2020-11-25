import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

//Base Class for Bloc Event extends Equatable to make it comparable
abstract class CounterBlocEvent extends Equatable{

}

class DecreaseCounterEvent extends CounterBlocEvent{

  //overide this method when class extends equatable

  @override
  // TODO: implement props
  List<Object> get props => [];
}


class IncreaseCounterEvent extends CounterBlocEvent{

//overide this method when class extends equatable

  @override
  // TODO: implement props
  List<Object> get props => [];
}


// enum CounterEvents{
//   increment, decrement
// }
//
// class CounterBloc extends Bloc<CounterEvents, int>{
//   CounterBloc(int initialState) : super(initialState);
//
//   @override
//   Stream<int> mapEventToState(CounterEvents event) async*{
//     switch(event){
//       case CounterEvents.increment:
//         yield state + 1;
//         break;
//       case CounterEvents.decrement:
//         yield state - 1;
//         break;
//     }
//   }
//
// }