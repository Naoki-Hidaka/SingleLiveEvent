import 'package:flutter_test/flutter_test.dart';

import 'package:single_live_event/single_live_event.dart';

void main() {
  test('single live event', () {
    final event = SingleLiveEvent<ExampleEvent>();
    late ExampleEvent lastValue;
    event.observe((event) {
      lastValue = event;
    });

    final event1 = ExampleEvent1();
    event.value = event1;
    expect(lastValue, event1);

    final event1_2 = ExampleEvent1();
    event.value = event1_2;
    expect(lastValue, event1_2);

    final event2 = ExampleEvent2(1);
    event.value = event2;
    expect(lastValue, event2);
    expect((lastValue as ExampleEvent2).num, 1);

    event.dispose();
  });
}

abstract class ExampleEvent {}
class ExampleEvent1 extends ExampleEvent {}
class ExampleEvent2 extends ExampleEvent {
  ExampleEvent2(this.num);
  final int num;
}