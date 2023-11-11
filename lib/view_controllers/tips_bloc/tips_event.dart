part of 'tips_bloc.dart';

abstract class TipsEvent extends Equatable {
  const TipsEvent();
}

class AddTipEvent extends TipsEvent {
  final String title;
  final String body;
  final bool isVIP;
  final TipType tipType;
  final String tipNum;
  final File coverFile;

  const AddTipEvent({
    required this.title,
    required this.body,
    required this.tipType,
    required this.tipNum,
    required this.isVIP,
    required this.coverFile,
  });

  @override
  List<Object> get props => [
        title,
        body,
        isVIP,
        coverFile,
        tipType,
        tipNum,
      ];

  @override
  String toString() {
    return 'AddTipEvent{title: $title, body: $body, isVIP: $isVIP, tipType: $tipType, tipNum: $tipNum, coverFile: $coverFile}';
  }
}

class UpdateTipEvent extends TipsEvent {
  final TipModel updatedTip;

  const UpdateTipEvent({
    required this.updatedTip,
  });

  @override
  List<Object> get props => [updatedTip];
}

class DeleteTipEvent extends TipsEvent {
  final String tipId;

  const DeleteTipEvent({
    required this.tipId,
  });

  @override
  List<Object> get props => [tipId];
}
