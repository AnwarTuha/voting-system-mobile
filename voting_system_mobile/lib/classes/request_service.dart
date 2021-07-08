import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:voting_system_mobile/model/candidate_poll_model.dart';
import 'package:voting_system_mobile/model/check_notification_model.dart';
import 'package:voting_system_mobile/model/has_voted_model.dart';
import 'package:voting_system_mobile/model/login_model.dart';
import 'package:voting_system_mobile/model/organization_model.dart';
import 'package:voting_system_mobile/model/poll_model.dart';
import 'package:voting_system_mobile/model/public_poll_model.dart';
import 'package:voting_system_mobile/model/register_model.dart';
import 'package:voting_system_mobile/model/result_model.dart';
import 'package:voting_system_mobile/model/role_detail.dart';
import 'package:voting_system_mobile/model/roles_model.dart';
import 'package:voting_system_mobile/model/update_profile_model.dart';
import 'package:voting_system_mobile/model/verification_request_model.dart';
import 'package:voting_system_mobile/model/vote_model.dart';
import 'package:voting_system_mobile/utils/app_url.dart';

import '../model/login_model.dart';

class RequestService {
  // Login service
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    String url = "${AppUrl.loginUrl}";
    var response;
    try {
      response = await http.post(
        Uri.parse(url),
        body: loginRequestModel.toJson(),
      );
      if (response != null) {
        print("success: ${response.body}");
        return LoginResponseModel.fromJson(
          new Map<String, dynamic>.from(
            json.decode(response),
          ),
        );
      } else {
        throw Exception();
      }
    } catch (e) {
      if (response != null) {
        return LoginResponseModel.fromJson(
          new Map<String, dynamic>.from(
            jsonDecode(response.body),
          ),
        );
      } else {
        print("Error: $response");
      }
    }
    return null;
  }

  // Register service
  Future<RegisterResponseModel> register(RegisterRequestModel registerRequestModel) async {
    String url = "${AppUrl.kBaseUrl}/Voters/register";
    var response;

    try {
      response = await http.post(
        Uri.parse(url),
        body: registerRequestModel.toJson(),
      );
      return RegisterResponseModel.fromJson(
        new Map<String, dynamic>.from(
          jsonDecode(response.body),
        ),
      );
    } catch (e) {
      print(response.body);
      return RegisterResponseModel.fromJson(
        new Map<String, dynamic>.from(
          jsonDecode(response.body),
        ),
      );
    }
  }

  // Fetch Organization Service

  Future<List<Organization>> fetchOrganizations() async {
    String url = "${AppUrl.kBaseUrl}/Organizations";
    var response;

    response = await http.get(Uri.parse(url));
    print("Success" + response.body);
    return organizationFromJson(response.body);
  }

  // Fetch Roles Service

  Future<RoleResponseModel> fetchRoles(RoleRequestModel roleRequestModel) async {
    String url = "${AppUrl.getRolesOrg}${roleRequestModel.orgId}";

    var response;
    try {
      response = await http.get(
        Uri.parse(url),
      );
      print(response.body);
      return RoleResponseModel.fromJson(
        new Map<String, dynamic>.from(
          jsonDecode(response.body),
        ),
      );
    } catch (e) {
      print(response.body);
      return RoleResponseModel.fromJson(
        new Map<String, dynamic>.from(
          jsonDecode(response.body),
        ),
      );
    }
  }

  // Fetch Poll Service

  Future<Polls> fetchPolls(PollRequestModel pollRequestModel) async {
    String url = "${AppUrl.kBaseUrl}/Polls/getUserPolls/${pollRequestModel.userId}";

    var response;

    try {
      response = await http.get(Uri.parse(url), headers: {'Authorization': '${pollRequestModel.authenticationToken}'});
      if (response != null) {
        return Polls.fromJson(new Map<String, dynamic>.from(jsonDecode(response.body)));
      } else {
        print("Response is Null: $response");
      }
    } catch (e) {
      print("Error: " + response.body);
      if (response != null) {
        return Polls.fromJson(new Map<String, dynamic>.from(jsonDecode(response.body)));
      }
    }

    return null;
  }

  // fetch pending polls

  Future<Polls> fetchPendingPolls(PollRequestModel pollRequestModel) async {
    String url = "${AppUrl.getPendingPollsUrl}/${pollRequestModel.userId}";

    var response;

    try {
      response = await http.get(Uri.parse(url), headers: {'Authorization': '${pollRequestModel.authenticationToken}'});
      print("Success(Fetch Pending request): ${response.body}");
      if (response != null) {
        return Polls.fromJson(new Map<String, dynamic>.from(jsonDecode(response.body)));
      }
    } catch (e) {
      print(e);
      print("Error(Fetch Pending request): ${response.body}");
      if (response != null) {
        return Polls.fromJson(new Map<String, dynamic>.from(jsonDecode(response.body)));
      }
    }

    return null;
  }

  // Send account for verification

  Future<VerificationResponseModel> submitAccountForVerification(VerificationRequestModel verificationRequestModel) async {
    String url = "${AppUrl.kBaseUrl}/Verifications";
    var response;

    try {
      response = await http.post(
        Uri.parse(url),
        body: verificationRequestModel.toJson(),
      );
      print(response.body);
      if (response != null) {
        return VerificationResponseModel.fromJson(
          new Map<String, dynamic>.from(
            json.decode(response.body),
          ),
        );
      }
    } catch (e) {
      if (response != null) {
        return VerificationResponseModel.fromJson(
          new Map<String, dynamic>.from(
            jsonDecode(response.body),
          ),
        );
      }
    }
    return null;
  }

  // Fetch role detail

  Future<RoleDetailResponseModel> requestRoleDetail(RoleDetailRequestModel roleDetailRequestModel) async {
    String url = "${AppUrl.kBaseUrl}/roles/getRoleDetails/${roleDetailRequestModel.roleId}";

    var response;

    try {
      response = await http.get(Uri.parse(url), headers: {'Authorization': '${roleDetailRequestModel.authenticationToken}'});
      if (response != null) {
        return RoleDetailResponseModel.fromJson(new Map<String, dynamic>.from(
          json.decode(response.body),
        ));
      }
    } catch (e) {
      if (response != null) {
        return RoleDetailResponseModel.fromJson(new Map<String, dynamic>.from(json.decode(response.body)));
      }
    }
    return null;
  }

  // vote on polls
  Future<VoteResponseModel> voteOnPoll(VoteRequestModel voteRequestModel) async {
    String url = "${AppUrl.voteOnPollUrl}/${voteRequestModel.pollId}";

    var response;

    try {
      response = await http.post(Uri.parse(url),
          body: voteRequestModel.toJson(), headers: {'Authorization': voteRequestModel.authenticationToken});
      if (response != null) {
        print("Success: ${response.body}");
        return VoteResponseModel.fromJson(new Map<String, dynamic>.from(
          json.decode(response.body),
        ));
      }
    } catch (e) {
      if (response != null) {
        print("Error: ${response.body}");
        return VoteResponseModel.fromJson(new Map<String, dynamic>.from(json.decode(response.body)));
      }
    }
    return null;
  }

  // request result of poll

  Future<ResultModel> requestResult(ResultRequestModel requestModel) async {
    String url = "${AppUrl.resultOfPollUrl}/${requestModel.userId}/poll/${requestModel.pollId}";

    var response;

    try {
      response = await http.get(Uri.parse(url), headers: {'Authorization': requestModel.authenticationToken});
      if (response != null) {
        print("From request: ${response.body}");
        return ResultModel.fromJson(new Map<String, dynamic>.from(jsonDecode(response.body)));
      } else {
        print("Response is Null: $response");
      }
    } catch (e) {
      print("Error: " + response.body);
      if (response != null) {
        return ResultModel.fromJson(new Map<String, dynamic>.from(jsonDecode(response.body)));
      }
    }

    return null;
  }

  // request public polls

  Future<PublicPollResponseModel> requestPublicPolls(PublicPollRequestModel pollRequestModel) async {
    String url = "${AppUrl.getPublicPollsUrl}";
    var response;

    try {
      response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": pollRequestModel.authenticationToken},
      );
      if (response != null) {
        return PublicPollResponseModel.fromJson(
          new Map<String, dynamic>.from(
            jsonDecode(response.body),
          ),
        );
      }
    } catch (e) {
      if (response != null) {
        return PublicPollResponseModel.fromJson(
          new Map<String, dynamic>.from(
            jsonDecode(response.body),
          ),
        );
      } else {
        print("(From Public Polls): Something went wrong");
      }
    }

    return null;
  }

  // check if user has already voted

  Future<UserHasVotedResponseModel> checkHasUserVoted(UserHasVotedRequestModel requestModel) async {
    String url = "${AppUrl.hasUserVoted}/${requestModel.userId}/poll/${requestModel.pollId}";

    var response;

    response = await http.get(Uri.parse(url), headers: {'Authorization': requestModel.authenticationToken});
    if (response != null) {
      print("Success(Check user has voted:) ${response.body}");
      return UserHasVotedResponseModel.fromJson(new Map<String, dynamic>.from(jsonDecode(response.body)));
    }
  }

  // get candidate details

  Future<CandidateResponseModel> getCandidateDetail(CandidateRequestModel candidateRequestModel) async {
    String url = "${AppUrl.getCandidateDetailsUrl}/${candidateRequestModel.pollId}/voter/${candidateRequestModel.voterId}";

    var response;

    try {
      response = await http.get(Uri.parse(url), headers: {'Authorization': candidateRequestModel.authenticationToken});
      if (response != null) {
        print("Success (Fetch candidate details): $response");
        return candidatePollResponseModelFromJson(response.body);
      } else {
        print("response is null");
      }
    } catch (e) {
      if (response != null) {
        print("Error (Fetch candidate details): $response");
        return candidatePollResponseModelFromJson(response.body);
      } else {
        print("response is null $e");
      }
    }

    return null;
  }

  Future<UpdateProfileResponseModel> updateProfile(UpdateProfileRequestModel requestModel) async {
    String url = "${AppUrl.updateProfileUrl}${requestModel.id}";

    var response;

    try {
      response = await http
          .patch(Uri.parse(url), body: requestModel.toJson(), headers: {'Authorization': requestModel.authenticationToken});
      if (response != null) {
        print("Success (Update Profile): ${response.body}");
        return updateProfileResponseModelFromJson(response.body);
      } else {
        print("response is null");
      }
    } catch (e) {
      if (response != null) {
        print("Error (Update Profile): ${response.body}");
        return updateProfileResponseModelFromJson(response.body);
      } else {
        print("response is null $e");
      }
    }

    return null;
  }

  Future<PublicVoteResponseModel> publicPollVote(PublicPollVoteModel voteModel) async {
    String url = "${AppUrl.voteOnPublicPollUrl}/${voteModel.pollId}/voter/${voteModel.userId}";

    var response;

    try {
      response = await http.patch(
        Uri.parse(url),
        body: voteModel.toJson(),
        headers: {'Authorization': voteModel.authenticationToken},
      );
      print("request is sent");
      if (response != null) {
        print("Success (Vote on Public Poll): ${response.body}");
        return publicVoteResponseModelFromJson(response);
      } else {
        print("Response is null");
      }
    } catch (e) {
      if (response != null) {
        print("Error (Vote on public poll): ${response.body}");
        return publicVoteResponseModelFromJson(response);
      } else {
        print("Something went wrong");
      }
    }

    return null;
  }

  checkNotificationAsSeen(CheckNotificationModel requestModel) async {
    String url = "${AppUrl.checkNotificationIsSeenUrl}/${requestModel.notificationId}/voter/${requestModel.userId}";

    var response;

    try {
      response = await http.patch(Uri.parse(url), headers: {'Authorization': requestModel.authenticationToken});
      print("Check is done ${response.body}");
    } catch (e) {
      print("Error(Check notificaiton): $e");
    }
  }

  Future fetchSinglePoll(SinglePollRequestModel requestModel) async {
    String url = "${AppUrl.getSinglePollUrl}/${requestModel.pollId}";

    var response;

    try {
      response = await http.get(Uri.parse(url), headers: {"Authorization": requestModel.accessToken});
      if (response != null) {
        print("Here (Fetch single Poll) : ${response.body}");
        return Poll.fromJson(response);
      } else {
        throw Exception();
      }
    } catch (e) {
      if (response != null) {
        print("Error (fetch single poll) : $response");
      } else {
        print("sth is wrong(fetch single poll)");
      }
    }
  }
}
