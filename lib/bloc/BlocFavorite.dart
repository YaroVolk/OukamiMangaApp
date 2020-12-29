import 'package:flutter_bloc/flutter_bloc.dart';

class BlocFavorite extends Bloc<List<Map>, List<Map>> {
  @override
  List<Map> get initialState => [];

  @override
  Stream<List<Map>> mapEventToState(List<Map> event) async* {
    yield event;
  }
}

class BlocFavoriteSort extends Bloc<String, String> {
  @override
  String get initialState => 'asc';

  @override
  Stream<String> mapEventToState(String event) async* {
    yield event;
  }
}

class BlocHistory extends Bloc<List<Map>, List<Map>> {
  @override
  List<Map> get initialState => [];

  @override
  Stream<List<Map>> mapEventToState(List<Map> event) async* {
    yield event;
  }
}
