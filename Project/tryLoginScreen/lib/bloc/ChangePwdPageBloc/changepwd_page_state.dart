import 'package:equatable/equatable.dart';


abstract class ChangePWDPageState extends Equatable{}


class  ChangePWDInitialState extends  ChangePWDPageState{

  @override

  List<Object> get props => throw UnimplementedError();
}
class  ChangePWDLoadingState extends  ChangePWDPageState{
  @override

  List<Object> get props => throw UnimplementedError();
}
class  ChangePWDSuccessState extends  ChangePWDPageState{
  @override

  List<Object> get props => throw UnimplementedError();
}
class  ChangePWDFailureState extends  ChangePWDPageState{
 
  String message;
   ChangePWDFailureState(this.message);
   @override
  List<Object> get props => throw UnimplementedError();
}