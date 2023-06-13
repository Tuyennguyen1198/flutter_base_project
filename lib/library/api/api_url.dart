

import '../server/app_configs.dart';

class ApiUrls{
  // Api ket noi bới trang web của kanzel
//  static final String loginKanZel = AppConfigs.apiServerKanZel + "/api/login";
  //
  static final String login = "${AppConfigs.apiServer}/login";
  static final String logOut = "${AppConfigs.apiServer}/logOut";
  static final String getMessageChatMobile = "${AppConfigs.apiServer}/getMessageChatMobile";
}