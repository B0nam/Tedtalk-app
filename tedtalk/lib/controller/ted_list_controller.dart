import 'package:tedtalk/models/ted_list.dart';
import 'package:tedtalk/models/ted_talk.dart';
import 'package:tedtalk/services/ted_list_service.dart';
import 'package:tedtalk/services/ted_talk_service.dart';

class TedListController {
  final TedTalkService _tedTalkService = TedTalkService();
  final TedListService _tedListService = TedListService();

  Future<void> addTedTalkToList(TedList tedList, TedTalk tedTalk) async {
    await _tedTalkService.createTedTalk(tedTalk);
    tedList.tedTalks.add(tedTalk.id);
    await _tedListService.updateTedList(tedList);
  }

  Future<void> removeTedTalkFromList(TedList tedList, String tedTalkId) async {
    tedList.tedTalks.remove(tedTalkId);
    await _tedListService.updateTedList(tedList);
  }

  Future<List<TedTalk>> fetchTedTalks(List<String> tedTalkIds) async {
    return Future.wait(
        tedTalkIds.map((id) => _tedTalkService.fetchTedTalkById(id)));
  }

  Future<void> deleteTedTalk(String tedTalkId) async {
    await _tedTalkService.deleteTedTalk(tedTalkId);
  }

  Future<void> updateTedList(TedList tedList) async {
    await _tedListService.updateTedList(tedList);
  }

  Future<void> deleteTedList(TedList tedList) async {
    for (String tedTalkId in tedList.tedTalks) {
      await _tedTalkService.deleteTedTalk(tedTalkId);
    }
    await _tedListService.deleteTedList(tedList.id);
  }
}
