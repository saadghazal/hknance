part of 'tips_bloc.dart';

abstract class TipsEvent extends Equatable {
  const TipsEvent();
}

class AddTipEvent extends TipsEvent {
  final String title;
  final String body;
  final bool isVIP;
  final File coverFile;
  final List<TipCategory> categories;
  final String tipType;
  final String tipAdvice;

  const AddTipEvent({
    required this.title,
    required this.body,
    required this.isVIP,
    required this.coverFile,
    required this.tipType,
    required this.categories,
    required this.tipAdvice,
  });

  @override
  List<Object> get props => [
        title,
        body,
        isVIP,
        coverFile,
    tipType,

    tipAdvice, categories,
      ];

  @override
  String toString() {
    return 'AddTipEvent{title: $title, body: $body, isVIP: $isVIP,  coverFile: $coverFile}';
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
