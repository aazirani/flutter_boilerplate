import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'error_provider.g.dart';

@Riverpod(keepAlive: true)
class ErrorController extends _$ErrorController {
  @override
  String? build() => null;

  void setError(String? error) {
    state = error;
  }

  void clearError() {
    state = null;
  }
}
