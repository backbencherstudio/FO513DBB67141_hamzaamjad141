import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/core/services/api_services/api_endpoints.dart';
import 'package:aviation_app/core/services/api_services/api_services.dart';
import 'package:aviation_app/core/services/local_storage_services/shared_preferences_services/sharedPref_service.dart';
import 'package:aviation_app/core/services/local_storage_services/shared_preferences_services/shared_preferences_key_name.dart';
import 'package:aviation_app/features/profile_screen/riverpod/delete_state_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deleteProvider = StateNotifierProvider<DeleteNotifier, DeleteStateModel>(
  (ref){

    return DeleteNotifier(); }
);
class DeleteNotifier extends StateNotifier<DeleteStateModel>{
  DeleteNotifier():super(DeleteStateModel());


Future<String> deleteUser()async{
 final userToken = await SharedPreferenceStorageService.getString(key: SharedPreferencesKeyName.userToken);

  try {

 state = state.copyWith(isLoading: true);

final headers = {
      'Authorization': '$userToken',
      'Content-Type': 'application/json',
    };

    final response = await ApiServices.instance.deleteData(endPoint: ApiEndPoints.deleteAccount, headers: headers);
    if(response['success']== true || response['success']=="true"){
      state = state.copyWith(success:"success");
      
       return "ok";
    }else{
       state = state.copyWith(isLoading: false, success: "failed");
      return "failed";
    }
  } catch (e) {
     state = state.copyWith(isLoading: false, success: "failed");
    throw Exception(e);
  }
}
}
