import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hknance/utils/notifications_center/notifications_center.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  late StreamSubscription streamSubscription;

  NotificationsCubit() : super(NotificationsState.initial()) {
    streamSubscription = FirebaseFirestore.instance
        .collection('news')
    .orderBy('createdAt',descending: true)
        .snapshots()
        .listen(
      (event) {
        event.docChanges.forEach((element) {
          print('''
          new Index: ${element.newIndex},
          ${element.doc.exists},
          
          ''');
        });
      },
    );
  }
}
