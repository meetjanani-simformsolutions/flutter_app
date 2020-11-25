import 'package:mobx/mobx.dart';
part 'countermobx.g.dart';

class CounterMobxStore = CounterMobx with _$CounterMobxStore;

abstract class CounterMobx with Store{
  @observable
  int counter = 0;

  @action
  void increment(){
     counter++;
  }
}