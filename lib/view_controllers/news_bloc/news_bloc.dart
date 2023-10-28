import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hknance/utils/errors/error_handler.dart';
import 'package:hknance/view_controllers/sign_up_cubit/sign_up_cubit.dart';

import '../../data_models/new_data_model.dart';
import '../../repositories/news_repository.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository _newsRepository;
  NewsBloc({required NewsRepository newsRepository})
      : _newsRepository = newsRepository,
        super(NewsState.initial()) {
    on<NewsEvent>(
      (event, emit) async {
        if (event is AddNewEvent) {
          emit(
            state.copyWith(
              loadingStatus: LoadingStatus.loading,
            ),
          );
          try {
            await _newsRepository.addNew(
              newModel: event.newModel,
              coverFile: event.newCover,
            );
            emit(
              state.copyWith(
                loadingStatus: LoadingStatus.loaded,
              ),
            );
          } on ErrorHandler catch (e) {
            emit(
              state.copyWith(
                loadingStatus: LoadingStatus.error,
                errorHandler: e,
              ),
            );
          }
        } else if (event is UpdateNewEvent) {
          emit(
            state.copyWith(
              loadingStatus: LoadingStatus.loading,
            ),
          );
          try {
            await _newsRepository.updateNew(
              newModel: event.newModel,
            );
            emit(
              state.copyWith(
                loadingStatus: LoadingStatus.loaded,
              ),
            );
          } on ErrorHandler catch (e) {
            emit(
              state.copyWith(
                loadingStatus: LoadingStatus.error,
                errorHandler: e,
              ),
            );
          }
        }
      },
    );
  }
}
