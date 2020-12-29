import 'dart:convert';

import 'package:Oukami/config/Database.dart';
import 'package:Oukami/models/ComicV1.dart';
import 'package:Oukami/models/ComicV2.dart';
import 'package:Oukami/models/ComicV3.dart';
import 'package:Oukami/models/OtherComic.dart';
import 'package:Oukami/models/SearchResult.dart';
import 'package:http/http.dart' as http;

import 'package:Oukami/models/detail_chapter.dart';
import 'package:Oukami/models/detail_comic.dart';

class ComicData {
  static getHomeData() async {
    final response = await http.get(Database.apiUrl);
    List<ComicV1> hotComic = json
        .decode(response.body)['hot_comic']
        .map<ComicV1>((e) => ComicV1.fromJson(e))
        .toList();
    List<ComicV2> projectComic = json
        .decode(response.body)['project_comic']
        .map<ComicV2>((e) => ComicV2.fromJson(e))
        .toList();
    List<ComicV3> latestChapter = json
        .decode(response.body)['latest_chapter']
        .map<ComicV3>((e) => ComicV3.fromJson(e))
        .toList();

    return {
      "hotComic": hotComic,
      "projectComic": projectComic,
      "latestChapter": latestChapter,
    };
  }

  static Future<DetailComic> getDetailKomik({id}) async {
    final response = json.decode(
        (await http.get('${Database.apiUrl}komik?id=$id')).body)['data'];
    return DetailComic.fromJson(response);
  }

  static Future<DetailChapter> getChapterKomik({id}) async {
    final response = json.decode(
        (await http.get('${Database.apiUrl}chapter?id=$id')).body)['data'];
    return DetailChapter.fromJson(response);
  }

  static getAllKomik({int page}) async {
    final List response = json.decode(
        (await http.get('${Database.apiUrl}daftar-komik?page=$page'))
            .body)['daftar_komik'];

    return response.map<SearchResult>((e) => SearchResult.fromJson(e)).toList();
  }

  static getSpecificComic({String keyword, int page}) async {
    List response = [];
    try {
      response = json.decode((await http
              .get('${Database.apiUrl}search?keyword=$keyword&page=$page'))
          .body)['results'];
    } catch (e) {}

    return response.map<SearchResult>((e) => SearchResult.fromJson(e)).toList();
  }

  static getChapterTerbaru({int page}) async {
    final List response = json.decode((await http
            .get('${Database.apiUrl}daftar-komik?page=$page&order=update'))
        .body)['daftar_komik'];

    return response.map<OtherComic>((e) => OtherComic.fromJson(e)).toList();
  }

  static getProjectTerbaru({int page}) async {
    final List response = json.decode(
        (await http.get('${Database.apiUrl}project-list?page=$page'))
            .body)['daftar_komik'];

    return response.map<OtherComic>((e) => OtherComic.fromJson(e)).toList();
  }
}
