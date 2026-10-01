import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'result_list_state.dart';

class ResultListCubit extends Cubit<ResultListState> {
  ResultListCubit() : super(ResultListInitial());
}
