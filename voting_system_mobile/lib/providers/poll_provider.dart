import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:voting_system_mobile/model/poll_model.dart';

class PollProvider extends ChangeNotifier {
  List<Poll> _allPolls = [];
  List<Poll> _livePolls = [];
  List<Poll> _upcomingPolls = [];
  List<Poll> _pendingPolls = [];
  List<Poll> _completedPolls = [];

  List<Poll> get allPolls => _allPolls;
  List<Poll> get upComingPolls => _upcomingPolls;
  List<Poll> get livePolls => _livePolls;
  List<Poll> get pendingPolls => _pendingPolls;
  List<Poll> get completedPolls => _completedPolls;

  void setAllPoll(List<Poll> polls) {
    _allPolls = polls.toSet().toList();
    notifyListeners();
  }

  void setAllPollsToEmpty() {
    _allPolls = [];
    _livePolls = [];
    _pendingPolls = [];
    _completedPolls = [];
    notifyListeners();
  }

  void setUpcomingPolls() {
    _upcomingPolls.addAll(_allPolls.where((element) => element.startDate.isAfter(DateTime.now())));
    _upcomingPolls = _upcomingPolls.distinct((element) => element.pollId).toList();
    notifyListeners();
  }

  void setLivePolls() {
    _livePolls.addAll(_allPolls.where((element) =>
        element.endDate.isAfter(DateTime.now()) && element.startDate.isBefore(DateTime.now()) && element.hasVoted == false));
    _livePolls = _livePolls.distinct((element) => element.pollId).toList();
    notifyListeners();
  }

  void setPendingPolls(List<Poll> pendingPolls) {
    _allPolls.addAll(pendingPolls);
    _allPolls = _allPolls.distinct((element) => element.pollId).toList();
    _pendingPolls = pendingPolls;
    _pendingPolls = _pendingPolls.distinct((element) => element.pollId).toList();
    notifyListeners();
  }

  void setCompletedPolls() {
    _completedPolls.addAll(
      _allPolls.where(
        (element) => element.endDate.isBefore(
          DateTime.now(),
        ),
      ),
    );
    _completedPolls = _completedPolls.distinct((element) => element.pollId).toList();
    notifyListeners();
  }

  void setUserHasVoted(String pollId) {
    //_allPolls[_allPolls.indexWhere((element) => element.pollId == pollId)].hasVoted = true;
    for (var poll in _allPolls) {
      if (poll.pollId == pollId) {
        poll.hasVoted = true;
      }
    }
    notifyListeners();
  }

  void setUserOptionForPoll(String option, String pollId) {
    for (var poll in _allPolls) {
      if (poll.pollId == pollId) {
        poll.userChoice = option;
      }
    }
  }

  void sortPollsByAlphabet() {
    _allPolls.sort((a, b) => a.pollTitle.compareTo(b.pollTitle));
    _livePolls.sort((a, b) => a.pollTitle.compareTo(b.pollTitle));
    _completedPolls.sort((a, b) => a.pollTitle.compareTo(b.pollTitle));
    _upcomingPolls.sort((a, b) => a.pollTitle.compareTo(b.pollTitle));
    _pendingPolls.sort((a, b) => a.pollTitle.compareTo(b.pollTitle));
    notifyListeners();
  }

  void sortPollsByEndDate() {
    _allPolls.sort((a, b) => a.endDate.compareTo(b.endDate));
    _livePolls.sort((a, b) => a.endDate.compareTo(b.endDate));
    _completedPolls.sort((a, b) => a.endDate.compareTo(b.endDate));
    _pendingPolls.sort((a, b) => a.endDate.compareTo(b.endDate));
    _upcomingPolls.sort((a, b) => a.endDate.compareTo(b.endDate));
    notifyListeners();
  }

  void sortPollsByStartDate() {
    _allPolls.sort((a, b) => a.startDate.compareTo(b.startDate));
    _livePolls.sort((a, b) => a.startDate.compareTo(b.startDate));
    _completedPolls.sort((a, b) => a.startDate.compareTo(b.startDate));
    _pendingPolls.sort((a, b) => a.startDate.compareTo(b.startDate));
    _upcomingPolls.sort((a, b) => a.startDate.compareTo(b.startDate));
    notifyListeners();
  }

  void sortPollsByType() {
    _allPolls.sort((a, b) => a.type.compareTo(b.type));
    _livePolls.sort((a, b) => a.type.compareTo(b.type));
    _completedPolls.sort((a, b) => a.type.compareTo(b.type));
    _upcomingPolls.sort((a, b) => a.type.compareTo(b.type));
    _pendingPolls.sort((a, b) => a.type.compareTo(b.type));
    notifyListeners();
  }

  Poll getAllPollByIndex(int index) => _allPolls[index];
  Poll getLivePollByIndex(int index) => _livePolls[index];
  Poll getPendingPollByIndex(int index) => _pendingPolls[index];
  Poll getCompletedPollByIndex(int index) => _completedPolls[index];

  void removeFromAllPollsByPollId(String pollId) {
    _allPolls.removeWhere((element) => element.pollId == pollId);
    _livePolls.removeWhere((element) => element.pollId == pollId);
    _pendingPolls.removeWhere((element) => element.pollId == pollId);
    _upcomingPolls.removeWhere((element) => element.pollId == pollId);
    _completedPolls.removeWhere((element) => element.pollId == pollId);
    notifyListeners();
  }
}
