class Config {
  static const String appName = 'Volunteer';
  static const String apiUrl = 'https://volunteer-kz.herokuapp.com/';
  static const String createVolunteer = 'user/createVolunteer';
  static const String createOrganizer = 'user/createOrganizer';
  static const String login = 'user/loginUser';
  static const String updateDataUser = 'user/updateDataUser';
  static const String deleteUser = 'user/deleteUser';
  static const String getUser = 'user/getUser';
  static const String getByEmail = 'user/getByEmail';
  static const String getUserEmail = 'user/getUserEmail';
  static const String getEvents = "event/get";
  static const String getOrganisers = "user/getOrganizers";
  static const String changePhoto = "user/changePhoto";
  static const String changeUser = "user/updateDataUser";
  static const String joinEvent = "user/joinToEvent";
  static const String leaveEvent = "user/leaveFromEvent";
  static const String isJoined = "event/check";
}
