import 'package:flutter/cupertino.dart';

class SingleLiveEvent<T> extends ValueNotifier<T?> {
  SingleLiveEvent() : super(null);

  bool _shouldNotify = false;
  Function(T)? _observer;

  void observe(Function(T) observer) {
    this._observer = observer;
    super.addListener(considerNotify);
  }

  @override
  void removeListener(VoidCallback listener) {
    _observer = null;
    super.removeListener(listener);
  }

  @override
  void dispose() {
    _observer = null;
    super.dispose();
  }

  @override
  set value(T? newValue) {
    _shouldNotify = true;
    super.value = newValue;
  }

  void considerNotify() {
    if (_shouldNotify && value != null) {
      _shouldNotify = false;
      _observer?.call(value!);
    }
  }
}
