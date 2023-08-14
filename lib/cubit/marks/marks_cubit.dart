import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_app/constants.dart';
import 'package:school_app/models/marks_model.dart';

part 'marks_state.dart';

class MarksCubit extends Cubit<MarksState> {
  MarksCubit() : super(MarksInitial());

  static MarksCubit get(context) => BlocProvider.of(context);

  int markTypeIndex = 0;

  void changeCatIndexGuest(id) {
    markTypeIndex = marksType.indexOf(marksType[id]);
    emit(ChangeMarkTypeIndexState());
  }


  /////////////////////////////////////////////////////////////////////////////

  MarksModel? marksModel;

  Future getMarksWithType({required int id}) async {
    emit(GetMarksLoading());



  }

}
