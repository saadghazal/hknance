import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hknance/data_models/tip_data_model.dart';
import 'package:hknance/repositories/tips_repository.dart';
import 'package:hknance/utils/errors/error_handler.dart';
import 'package:hknance/view_controllers/sign_up_cubit/sign_up_cubit.dart';

part 'tips_event.dart';
part 'tips_state.dart';

class TipsBloc extends Bloc<TipsEvent, TipsState> {
  final TipsRepository _tipsRepository;
  TipsBloc({required TipsRepository tipsRepository})
      : _tipsRepository = tipsRepository,
        super(TipsState.initial()) {
    on<TipsEvent>((event, emit) async {
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.loading,
        ),
      );
      if (event is AddTipEvent) {
        if (event.title.isEmpty ||
            event.body.isEmpty ||
            event.coverFile.path.isEmpty) {
          emit(
            state.copyWith(
              loadingStatus: LoadingStatus.error,
              errorHandler: const ErrorHandler(
                code: '',
                message: 'Please fill the missing fields',
                plugin: '',
              ),
            ),
          );
          return;
        }
        try {
          TipModel newTip = TipModel(
            tipTitle: event.title,
            tipCover: '',
            tipDescription: event.body,
            isVIP: event.isVIP,
            createdAt: DateTime.now(),
          );
          await _tipsRepository.addTip(
            tipModel: newTip,
            coverFile: event.coverFile,
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
    });
  }
}
