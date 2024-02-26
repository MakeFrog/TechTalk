// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:techtalk/core/utils/base/base_no_param_use_case.dart';
// import 'package:techtalk/core/utils/result.dart';
// import 'package:techtalk/features/system/repositories/system_repository.dart';
//
// class SetEntryFlowUseCase extends BaseNoParamUseCase<Result<void>> {
//   SetEntryFlowUseCase(this._repository);
//   final SystemRepository _repository;
//
//   @override
//   FutureOr<Result<void>> call() async {
//     final connectivityResult = await Connectivity().checkConnectivity();
//     final response = await _repository.getVersionInfo();
//     final version = response.getOrThrow();
//   }
// }
