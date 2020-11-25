
//Base class for all the Bloc states
import 'package:equatable/equatable.dart';

abstract class CounterBlocState extends Equatable{

}

class LatestCounterState extends CounterBlocState{
  final int newCounterValue;

  LatestCounterState({this.newCounterValue});

  //overide this method as base class extends equatable and pass property inside props list
  @override
  // TODO: implement props
  List<Object> get props => [newCounterValue];
}