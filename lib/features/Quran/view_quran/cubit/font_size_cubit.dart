import 'package:flutter_bloc/flutter_bloc.dart';

class FontSizeCubit extends Cubit<double> {
  FontSizeCubit() : super(20.0); // Default font size

  void setFontSize(double newSize) => emit(newSize); // Update font size
}
