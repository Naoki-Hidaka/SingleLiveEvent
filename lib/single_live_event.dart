import 'package:flutter/cupertino.dart';

class SingleLiveEvent<T> extends ValueNotifier<T?> {
  SingleLiveEvent() : super(null);

  bool shouldNotify = false;
  Function(T)? observer;

  void observe(Function(T) observer) {
    this.observer = observer;
    super.addListener(considerNotify);
  }

  @override
  void removeListener(VoidCallback listener) {
    observer = null;
    super.removeListener(listener);
  }

  @override
  void dispose() {
    observer = null;
    super.dispose();
  }

  @override
  set value(T? newValue) {
    shouldNotify = true;
    super.value = newValue;
  }

  void considerNotify() {
    if (shouldNotify && value != null) {
      shouldNotify = false;
      observer?.call(value!);
    }
  }
}
