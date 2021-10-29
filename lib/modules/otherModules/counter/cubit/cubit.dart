import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/modules/otherModules/counter/cubit/states.dart';

class CounterCubit extends Cubit<CounterStates>
{
CounterCubit() : super(CounterInitialState());
static CounterCubit get(context)=> BlocProvider.of(context);
int counter =0;



void minus()
{
  counter --;
  emit(CounterMinusState(counter));
}
void plus()
{
  counter ++;
  emit(CounterPlusState(counter));
}

}