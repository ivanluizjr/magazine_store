import 'package:flutter/foundation.dart';

abstract class ReactiveService<State> implements ValueListenable<State> {
  bool get hasListeners;

  void emit(State newState) {
    throw UnimplementedError();
  }
}

class ReactiveServiceImpl<State> implements ReactiveService<State> {
  final State initialState;
  late final ValueNotifier<State> _notifier;

  ReactiveServiceImpl(this.initialState) {
    _notifier = ValueNotifier<State>(initialState);
  }

  @override
  void addListener(VoidCallback listener) {
    _notifier.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _notifier.removeListener(listener);
  }

  @override
  get value => _notifier.value;

  @override

  // ignore: invalid_use_of_protected_member
  bool get hasListeners => _notifier.hasListeners;

  @override
  void emit(State newState) {
    _notifier.value = newState;
  }
}
