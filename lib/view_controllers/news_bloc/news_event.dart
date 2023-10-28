part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}


class AddNewEvent extends NewsEvent {
  final NewModel newModel;
  final File newCover;

  const AddNewEvent({
    required this.newModel,
    required this.newCover,
  });

  @override
  List<Object> get props => [newModel, newCover];
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