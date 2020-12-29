import 'dart:convert';

import 'package:Oukami/database/ChapterManga.dart';

import 'package:Oukami/config/Database.dart';
import 'package:Oukami/models/AllManga.dart';
import 'package:Oukami/models/BestSeries.dart';
import 'package:Oukami/models/DetailManga.dart';
import 'package:Oukami/models/Genre/ActionGenre.dart';
import 'package:Oukami/models/Genre/AdventureGenre.dart';
import 'package:Oukami/models/Genre/ComedyGenre.dart';
import 'package:Oukami/models/Genre/DramaGenre.dart';
import 'package:Oukami/models/Genre/FantasyGenre.dart';
import 'package:Oukami/models/Genre/HaremGenre.dart';
import 'package:Oukami/models/Genre/HorrorGenre.dart';
import 'package:Oukami/models/Genre/MartialartsGenre.dart';
import 'package:Oukami/models/Genre/ShoujoGenre.dart';
import 'package:Oukami/models/Genre/ShounenGenre.dart';
import 'package:Oukami/models/Genre/ThrillerGenre.dart';
import 'package:Oukami/models/HomeManga.dart';
import 'package:Oukami/models/LatestChapterManga.dart';
import 'package:Oukami/models/MangaList.dart';
import 'package:Oukami/models/MangaV1.dart';
import 'package:Oukami/models/ManhuaList.dart';
import 'package:Oukami/models/ManhwaList.dart';
import 'package:Oukami/models/SearchManga.dart';
import 'package:http/http.dart' as http;

class MangaData {
  static getHomeData() async {
    final response = await http.get(Indonesia.hotMangaUrl);
    final response1 = await http.get(Indonesia.bestSeriesUrl);
    final response2 = await http.get(Indonesia.homeUrl);
    final response3 = await http.get(Indonesia.latestUpdateUrl);
    final response4 = await http.get(Indonesia.allUrl);
    final response5 = await http.get(Indonesia.actionGenreUrl);
    final response6 = await http.get(Indonesia.adventureGenreUrl);
    final response7 = await http.get(Indonesia.comedyGenreUrl);
    final response8 = await http.get(Indonesia.dramaGenreUrl);
    final response9 = await http.get(Indonesia.fantasyGenreUrl);
    final response10 = await http.get(Indonesia.haremGenreUrl);
    final response11 = await http.get(Indonesia.horrorGenreUrl);
    final response12 = await http.get(Indonesia.martialartsGenreUrl);
    final response13 = await http.get(Indonesia.shoujoGenreUrl);
    final response14 = await http.get(Indonesia.shounenGenreUrl);
    final response15 = await http.get(Indonesia.thrillerGenreUrl);
    final response16 = await http.get(IndonesiaLocal.hotMangaUrlLocal);
    final response17 = await http.get(IndonesiaLocal.bestSeriesUrlLocal);
    final response18 = await http.get(IndonesiaLocal.homeUrlLocal);
    final response19 = await http.get(IndonesiaLocal.latestUpdateUrlLocal);
    final response20 = await http.get(IndonesiaLocal.allUrlLocal);

    List<MangaV1> popularManga = json
        .decode(response.body)
        .map<MangaV1>((e) => MangaV1.fromJson(e))
        .toList();
    List<BestSeries> bestSeriesManga = json
        .decode(response1.body)
        .map<BestSeries>((e) => BestSeries.fromJson(e))
        .toList();
    List<HomeManga> homeManga = json
        .decode(response2.body)['manga_list']
        .map<HomeManga>((e) => HomeManga.fromJson(e))
        .toList();
    List<LatestChapterManga> latestChapterManga = json
        .decode(response3.body)['latestUpdateList']
        .map<LatestChapterManga>((e) => LatestChapterManga.fromJson(e))
        .toList();
    List<AllManga> allManga = json
        .decode(response4.body)['manga_list']
        .map<AllManga>((e) => AllManga.fromJson(e))
        .toList();
    List<ActionGenre> actionManga = json
        .decode(response5.body)['result']
        .map<ActionGenre>((e) => ActionGenre.fromJson(e))
        .toList();
    List<AdventureGenre> adventureManga = json
        .decode(response6.body)['result']
        .map<AdventureGenre>((e) => AdventureGenre.fromJson(e))
        .toList();
    List<ComedyGenre> comedyManga = json
        .decode(response7.body)['result']
        .map<ComedyGenre>((e) => ComedyGenre.fromJson(e))
        .toList();
    List<DramaGenre> dramaManga = json
        .decode(response8.body)['result']
        .map<DramaGenre>((e) => DramaGenre.fromJson(e))
        .toList();
    List<FantasyGenre> fantasyManga = json
        .decode(response9.body)['result']
        .map<FantasyGenre>((e) => FantasyGenre.fromJson(e))
        .toList();
    List<HaremGenre> haremManga = json
        .decode(response10.body)['result']
        .map<HaremGenre>((e) => HaremGenre.fromJson(e))
        .toList();
    List<HorrorGenre> horrorManga = json
        .decode(response11.body)['result']
        .map<HorrorGenre>((e) => HorrorGenre.fromJson(e))
        .toList();
    List<MartialartsGenre> martialartsManga = json
        .decode(response12.body)['result']
        .map<MartialartsGenre>((e) => MartialartsGenre.fromJson(e))
        .toList();
    List<ShoujoGenre> shoujoManga = json
        .decode(response13.body)['result']
        .map<ShoujoGenre>((e) => ShoujoGenre.fromJson(e))
        .toList();
    List<ShounenGenre> shounenManga = json
        .decode(response14.body)['result']
        .map<ShounenGenre>((e) => ShounenGenre.fromJson(e))
        .toList();
    List<ThrillerGenre> thrillerManga = json
        .decode(response15.body)['result']
        .map<ThrillerGenre>((e) => ThrillerGenre.fromJson(e))
        .toList();
    List<MangaV1> popularMangaLocal = json
        .decode(response16.body)
        .map<MangaV1>((e) => MangaV1.fromJson(e))
        .toList();
    List<BestSeries> bestSeriesLocal = json
        .decode(response17.body)
        .map<BestSeries>((e) => BestSeries.fromJson(e))
        .toList();
    List<HomeManga> homeMangaLocal = json
        .decode(response18.body)['manga_list']
        .map<HomeManga>((e) => HomeManga.fromJson(e))
        .toList();
    List<LatestChapterManga> latestChapterMangaLocal = json
        .decode(response19.body)['latestUpdateList']
        .map<LatestChapterManga>((e) => LatestChapterManga.fromJson(e))
        .toList();
    List<AllManga> allMangaLocal = json
        .decode(response20.body)['manga_list']
        .map<AllManga>((e) => AllManga.fromJson(e))
        .toList();

    return {
      "popularManga": popularManga,
      "bestSeriesManga": bestSeriesManga,
      "homeManga": homeManga,
      "latestChapterManga": latestChapterManga,
      "allManga": allManga,
      "actionManga": actionManga,
      "adventureManga": adventureManga,
      "comedyManga": comedyManga,
      "dramaManga": dramaManga,
      "fantasyManga": fantasyManga,
      "haremManga": haremManga,
      "horrorManga": horrorManga,
      "martialartsManga": martialartsManga,
      "shoujoManga": shoujoManga,
      "shounenManga": shounenManga,
      "thrillerManga": thrillerManga,
      "popularMangaLocal": popularMangaLocal,
      "bestSeriesLocal": bestSeriesLocal,
      "homeMangaLocal": homeMangaLocal,
      "latestChapterMangaLocal": latestChapterMangaLocal,
      "allMangaLocal": allMangaLocal,
    };
  }

  static Future<DetailManga> getDetailManga({id}) async {
    final response =
        json.decode((await http.get('${Indonesia.detailUrl}$id')).body);
    return DetailManga.fromJson(response);
  }

  static Future<ChapterManga> getChapterManga({id}) async {
    final response = json
        .decode((await http.get('${Indonesia.chapterUrl}$id')).body)['data'];
    return ChapterManga.fromJson(response);
  }

  static getSearch({String query}) async {
    List response = [];
    try {
      response =
          json.decode((await http.get('${Indonesia.searchUrl}$query')).body);
    } catch (e) {}

    return response.map<SearchManga>((e) => SearchManga.fromJson(e)).toList();
  }

  static getMangaChapter({int page}) async {
    final List response = json.decode(
        (await http.get('${Indonesia.listMangaUrl}$page')).body)['result'];

    return response.map<MangaList>((e) => MangaList.fromJson(e)).toList();
  }

  static getMangaProject({int page}) async {
    final List response = json.decode(
        (await http.get('${Indonesia.listMangaUrl}$page')).body)['result'];

    return response.map<MangaList>((e) => MangaList.fromJson(e)).toList();
  }

  static getManhwaChapter({int page}) async {
    final List response = json.decode(
        (await http.get('${Indonesia.listManhwaUrl}$page')).body)['result'];

    return response.map<ManhwaList>((e) => ManhwaList.fromJson(e)).toList();
  }

  static getManhwaProject({int page}) async {
    final List response = json.decode(
        (await http.get('${Indonesia.listManhwaUrl}$page')).body)['result'];

    return response.map<ManhwaList>((e) => ManhwaList.fromJson(e)).toList();
  }

  static getManhuaChapter({int page}) async {
    final List response = json.decode(
        (await http.get('${Indonesia.listManhuaUrl}$page')).body)['result'];

    return response.map<ManhuaList>((e) => ManhuaList.fromJson(e)).toList();
  }

  static getManhuaProject({int page}) async {
    final List response = json.decode(
        (await http.get('${Indonesia.listManhuaUrl}$page')).body)['result'];

    return response.map<ManhuaList>((e) => ManhuaList.fromJson(e)).toList();
  }
}
