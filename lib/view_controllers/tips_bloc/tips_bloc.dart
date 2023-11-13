import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:hknance/data_models/tip_data_model.dart';
import 'package:hknance/repositories/tips_repository.dart';
import 'package:hknance/utils/errors/error_handler.dart';
import 'package:hknance/view_controllers/sign_up_cubit/sign_up_cubit.dart';
import 'package:hknance/view_controllers/tip_type_cubit/tip_type_cubit.dart';

part 'tips_event.dart';
part 'tips_state.dart';

class TipsBloc extends Bloc<TipsEvent, TipsState> {
  final TipsRepository _tipsRepository;
  TipsBloc({required TipsRepository tipsRepository})
      : _tipsRepository = tipsRepository,
        super(TipsState.initial()) {
    on<TipsEvent>(
      (event, emit) async {
        emit(
          state.copyWith(
            loadingStatus: LoadingStatus.loading,
          ),
        );
        if (event is AddTipEvent) {
          await addTip(event, emit);
        } else if (event is UpdateTipEvent) {
          await updateTip(event, emit);
        } else if (event is DeleteTipEvent) {
          await deleteTip(event, emit);
        }
      },
    );
  }
  Future<void> addTip(AddTipEvent event, Emitter emit) async {
    print(event.toString());
    if (event.title.isEmpty ||
        event.body.isEmpty ||
        event.coverFile.path.isEmpty) {
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          errorHandler: ErrorHandler(
            code: '',
            message: 'fill_fields'.tr,
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

  Future<void> updateTip(UpdateTipEvent event, Emitter emit) async {
    if (event.updatedTip.tipTitle.isEmpty ||
        event.updatedTip.tipDescription.isEmpty) {
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          errorHandler: ErrorHandler(
            code: '',
            message: 'fill_fields'.tr,
            plugin: '',
          ),
        ),
      );
      return;
    }
    try {
      await _tipsRepository.updateTip(
        tipModel: event.updatedTip,
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

  Future<void> deleteTip(DeleteTipEvent event, Emitter emit) async {
    try {
      await _tipsRepository.deleteTip(
        tipId: event.tipId,
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
}
