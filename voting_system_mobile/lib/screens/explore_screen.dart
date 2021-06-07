import 'package:flutter/material.dart';
import 'package:voting_system_mobile/classes/request_service.dart';
import 'package:voting_system_mobile/model/public_poll_model.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {

  Future futurePolls;
  List<PublicPollResponseModel> polls = [];

  @override
  void initState() {
    super.initState();
    _getPublicVotes();
  }

  _getPublicVotes() async{
    await RequestService().requestPublicPoll().then((response){
      print('${response.pollTitle}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Explorer Page"),),
    );
  }
}
