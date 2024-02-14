#include <flutter_linux/flutter_linux.h>

FlMethodResponse *get_name_of_internet() {
  g_autoptr(FlValue) result = fl_value_new_string("Internet");
  return FL_METHOD_RESPONSE(fl_method_success_response_new(result));
}

FlMethodResponse *get_flutter_channel_response(FlMethodCall *method_call) {
  FlMethodResponse *response = nullptr;

  if (strcmp(fl_method_call_get_name(method_call), "getInternetName") == 0) {
    response = get_name_of_internet();
  } else {
    response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
  }

  return response;
}