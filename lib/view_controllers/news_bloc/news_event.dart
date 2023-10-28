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