import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Oukami/models/download_status.dart';

class BlocDownload extends Bloc<DownloadStatus, DownloadStatus> {
  @override
  DownloadStatus get initialState => DownloadStatus(
        currentIndex: 0,
        total: 0,
        percent: 0,
      );

  @override
  Stream<DownloadStatus> mapEventToState(DownloadStatus event) async* {
    yield event;
  }
}

class BlocDownloadAlredy extends Bloc<List<Map>, List<Map>> {
  @override
  List<Map> get initialState => [];

  @override
  Stream<List<Map>> mapEventToState(List<Map> event) async* {
    yield event;
  }
}

class BlocDownloadSetting extends Bloc<bool, bool> {
  @override
  bool get initialState => false;

  @override
  Stream<bool> mapEventToState(bool event) async* {
    yield event;
  }
}

class BlocDownloadedChapter extends Bloc<List<Map>, List<Map>> {
  @override
  List<Map> get initialState => [];

  @override
  Stream<List<Map>> mapEventToState(List<Map> event) async* {
    yield event;
  }
}

