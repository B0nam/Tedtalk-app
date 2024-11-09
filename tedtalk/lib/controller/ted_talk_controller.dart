import 'package:tedtalk/models/ted_talk.dart';
import 'package:tedtalk/services/ted_talk_service.dart';

class TedTalkController {
  final TedTalkService _tedTalkService = TedTalkService();

  Future<TedTalk> createTedTalk(TedTalk tedTalk) async {
    return await _tedTalkService.createTedTalk(tedTalk);
  }

  Future<void> deleteTedTalk(String tedTalkId) async {
    await _tedTalkService.deleteTedTalk(tedTalkId);
  }

  Future<TedTalk> fetchTedTalkById(String id) async {
    return await _tedTalkService.fetchTedTalkById(id);
  }

  Future<void> updateTedTalk(TedTalk tedTalk) async {
    await _tedTalkService.updateTedTalk(tedTalk);
  }
}
