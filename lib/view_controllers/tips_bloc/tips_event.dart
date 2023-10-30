part of 'tips_bloc.dart';

abstract class TipsEvent extends Equatable {
  const TipsEvent();
}


class AddTipEvent extends TipsEvent {
  final String title;
  final String body;
  final bool isVIP;
  final File coverFile;

  const AddTipEvent({
    required this.title,
    required this.body,
    required this.isVIP,
    required this.coverFile,
  });

  @override
  List<Object> get props => [title, body, isVIP, coverFile];
}

class UpdateTipEvent extends TipsEvent {
  final TipModel updatedTip;

  const UpdateTipEvent({
    required this.updatedTip,
  });

  @override
  List<Object> get props => [updatedTip];
}