import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show Locale;
import 'package:meta/meta.dart';
import 'package:student_app/prefs/preferences_base.dart';
part 'locale_state.dart';


class LocaleCubit extends Cubit<LocaleState> {

  LocaleCubit() : super(const SelectedLocale(Locale('en')));
// Here we initialize the object to the last saved locale and default to 'ar' if there is none


// Method that saves and emits the new locale
  Future<void> _changeLocale(String locale) async {
    PreferencesHelper.saveString('locale', locale);
    emit(SelectedLocale(Locale(locale)));
  }

  void getStartLang() async {
    String langCode = await PreferencesHelper.getString('locale', 'ar');
    emit(SelectedLocale(Locale(langCode)));
  }

  void toEnglish() => _changeLocale('en');
  void toArabic() => _changeLocale('ar');
}

