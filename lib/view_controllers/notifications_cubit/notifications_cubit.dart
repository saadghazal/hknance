import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data_models/tip_data_model.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {

  NotificationsCubit() : super(NotificationsState.initial());

  Future<void> sendNotification({
    required bool isVIP,
    required List<TipCategory> tipCategories,
    required String tipAdvice,
    required String tipType,
  }) async {
    print(
      '''
      $isVIP
      $tipAdvice
      $tipType
      '''
    );

    final splittedType = tipType.split(' ');
    splittedType.insert(1, tipAdvice);
    String notificationBody = '';
    tipCategories.forEach((element) {
      if(element.type == "TP"){
        notificationBody += '${element.type} ✅ ${element.number}\n';
      }
    });
    notificationBody+= 'SL ❌ سيتم التحديث بعد قليل';
    try {
      final url = Uri.parse("https://fcm.googleapis.com/fcm/send");
      final response = await http.post(
        url,
        headers: {
          'Authorization':
              'key=AAAACt88FA4:APA91bFLs2e2PsEb3Ul6jcs7scuaVaQciaB6Uk9kJ9ZBfKD3ScK_N0VjTZb7U7B1wx2M_d6qqokW9s-OqlIkPAZ4ycWoEQHj5KkYTxpiKof0bKXC3PAj4x6LqctukJqqHlMaQj9jQX4i',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(
          <String, dynamic>{
            "notification": <String, dynamic>{
              "title": '🟢 ${splittedType.join(" ")}',
              "body": notificationBody,
            },
            "content_available": true,
            "priority": "high",
            "to": isVIP? "/topics/vipTips" : "/topics/tips",
          },
        ),
      );
      print(response.body);
    } catch (e) {
      print(e);
    }
  }
}
