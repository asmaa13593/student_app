import 'package:get_it/get_it.dart';
import 'package:student_app/business_logic/cubits/auth/auth_cubit.dart';
import 'package:student_app/business_logic/cubits/forgetpassword/forget_password_cubit.dart';
import 'package:student_app/business_logic/cubits/locale/locale_cubit.dart';
import 'package:student_app/business_logic/home/home_cubit.dart';
import 'package:student_app/business_logic/home/material_cubit.dart';
import 'package:student_app/data/api/dio_consumer.dart';
import 'package:student_app/data/api/http_consumer.dart';
import 'package:student_app/data/repositories/auth_repository.dart';
import 'package:student_app/data/repositories/forget_password_repository.dart';
import 'package:student_app/data/repositories/home_repository.dart';

final sl = GetIt.instance;
Future<void> init() async {
  sl.registerFactory<LocaleCubit>(() => LocaleCubit());
  sl.registerFactory<AuthCubit>(
      () => AuthCubit(AuthRepository(apiConsumer: DioConsumer())));
  sl.registerFactory<ForgetPasswordCubit>(() => ForgetPasswordCubit(
      ForgetPasswordRepository(apiConsumer: DioConsumer())));
  sl.registerFactory<HomeCubit>(
      () => HomeCubit(HomeRepository(apiConsumer: DioConsumer())));
  sl.registerFactory<MaterialCubit>(
      () => MaterialCubit(HomeRepository(apiConsumer: DioConsumer())));

  sl.registerLazySingleton<HttpConsumer>(() => HttpConsumer());
  sl.registerLazySingleton<DioConsumer>(() => DioConsumer());
}
