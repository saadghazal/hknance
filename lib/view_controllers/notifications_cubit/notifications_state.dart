part of 'notifications_cubit.dart';

class NotificationsState extends Equatable {
  final int docSize;
  const NotificationsState({required this.docSize});

  factory NotificationsState.initial(){
    return NotificationsState(docSize: 0);
  }

  @override
  List<Object> get props => [docSize];

  NotificationsState copyWith({
    int? docSize,
  }) {
    return NotificationsState(
      docSize: docSize ?? this.docSize,
    );
  }
}

