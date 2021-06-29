abstract class AppUrl {
  static const String kBaseUrl = "https://voting-system2.herokuapp.com/api";
  static const String loginUrl = "$kBaseUrl/Voters/signin";
  static const String registerUrl = "$kBaseUrl/Voters/register";
  static const String organizationsUrl = "$kBaseUrl/Organizations";
  static const String rolesUrl = "$kBaseUrl/roles/getRolesInOrg";
  static const String verificationUrl = "$kBaseUrl/Verifications";
  static const String roleDetailUrl = "$kBaseUrl/roles/getRoleDetails";
  static const String voteOnPollUrl = "$kBaseUrl/Voters/vote";
  static const String resultOfPollUrl = "$kBaseUrl/Voters/getResults";
  static const String hasUserVoted = "$kBaseUrl/Voters/hasVoted";
  static const String getRolesOrg = "$kBaseUrl/roles/getRolesInOrg/";
  static const String getPendingPollsUrl =
      "$kBaseUrl/Polls/getUserPendingVotes";
  static const String getPublicPollsUrl =
      "$kBaseUrl/publicVotes?filter[where][isVerified]=true";
  static const String getCandidateDetailsUrl =
      "$kBaseUrl//Polls/candidatePollDetails";
  static const String socketIo = "https://voting-system2.herokuapp.com";
  static const String updateProfileUrl = "$kBaseUrl/Voters/editCredentials/";
  static const String voteOnPublicPollUrl = "$kBaseUrl/Voters/publicVote";
}
