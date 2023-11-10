part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}


class AddNewEvent extends NewsEvent {
  final NewModel newModel;
  final File newCover;
  final bool isAnalysis;

  const AddNewEvent({
    required this.newModel,
    required this.newCover,
    required this.isAnalysis
  });

  @override
  List<Object> get props => [newModel, newCover,isAnalysis,];
}

class UpdateNewEvent extends NewsEvent {
  final NewModel newModel;

  const UpdateNewEvent({
    required this.newModel,
  });

  @override
  List<Object> get props => [newModel];
}

class DeleteNewEvent extends NewsEvent {
  final String newId;

  const DeleteNewEvent({
    required this.newId,
  });

  @override
  List<Object> get props => [newId];
}