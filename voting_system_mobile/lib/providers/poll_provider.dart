
import 'package:voting_system_mobile/model/poll_model.dart';
import 'package:flutter/material.dart';
import 'package:darq/darq.dart';

class PollProvider extends ChangeNotifier{

  List<Poll> _allPolls = [];
  List<Poll> _livePolls = [];
  List<Poll> _pendingPolls = [];
  List<Poll> _completedPolls = [];

  List<Poll> get allPolls => _allPolls;
  List<Poll> get livePolls => _livePolls;
  List<Poll> get pendingPolls => _pendingPolls;
  List<Poll> get completedPolls => _completedPolls;

  void setAllPoll(List<Poll> polls){
    _allPolls = polls.toSet().toList();
    notifyListeners();
  }

  void setAllPollsToEmpty(){
    _allPolls = [];
    _livePolls = [];
    _pendingPolls = [];
    _completedPolls = [];
    notifyListeners();
  }

  void setLivePolls(){
    _livePolls.addAll(_allPolls.where((element) => element.endDate.isAfter(DateTime.now()) && element.hasVoted == false));
    _livePolls = _livePolls.distinct((element) => element.pollId).toList();
    notifyListeners();
  }

  void setPendingPolls(List<Poll> pendingPolls){
    _pendingPolls = pendingPolls;
    notifyListeners();
  }

  void setCompletedPolls(){
    _completedPolls.addAll(_allPolls.where((element) => element.endDate.isBefore(DateTime.now())));
    _completedPolls = _completedPolls.distinct((element) => element.pollId).toList();
    notifyListeners();
  }

  void setHasUserHasVoted(bool hasVoted, String pollId){
    for (var poll in _allPolls){
      if (poll.pollId == pollId){
        if (hasVoted){
          poll.hasVoted = true;
        } else {
          poll.hasVoted = false;
        }
      }
    }
    notifyListeners();
  }



  Poll getAllPollByIndex(int index) => _allPolls[index];
  Poll getLivePollByIndex(int index) => _livePolls[index];
  Poll getPendingPollByIndex(int index) => _pendingPolls[index];
  Poll getCompletedPollByIndex(int index) => _completedPolls[index];

}