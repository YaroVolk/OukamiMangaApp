import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocWidget extends Bloc<ThemeMode, ThemeMode> {
  @override
  ThemeMode get initialState => ThemeMode.system;

  @override
  Stream<ThemeMode> mapEventToState(ThemeMode event) async* {
    yield event;
  }
}

class BlocBlur extends Bloc<double, double> {
  @override
  double get initialState => 0.0;

  @override
  Stream<double> mapEventToState(double event) async* {
    yield event;
  }
}

class BlocScroll extends Bloc<bool, ScrollPhysics> {
  @override
  ScrollPhysics get initialState => NeverScrollableScrollPhysics();

  @override
  Stream<ScrollPhysics> mapEventToState(bool event) async* {
    yield event
        ? AlwaysScrollableScrollPhysics()
        : NeverScrollableScrollPhysics();
  }
}

class BlocSliver extends Bloc<bool, bool> {
  @override
  bool get initialState => false;

  @override
  Stream<bool> mapEventToState(bool event) async* {
    yield event;
  }
}
