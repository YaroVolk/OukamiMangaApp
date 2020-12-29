import 'package:flutter_bloc/flutter_bloc.dart';

class BlocChapter extends Bloc<List<String>, List<String>> {
  @override
  List<String> get initialState => [];

  @override
  Stream<List<String>> mapEventToState(List<String> event) async* {
    yield event;
  }
}

class BlocChapterReverse extends Bloc<bool, bool> {
  bool initState = false;

  @override
  bool get initialState => initState;

  @override
  Stream<bool> mapEventToState(event) async* {
    yield event;
  }
}
