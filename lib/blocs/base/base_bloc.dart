import 'package:logging/logging.dart';
import 'package:new_artist_project/blocs/base/baseEvent.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc<T extends BaseEvent> {
  final Logger _logger = Logger("BaseBloc");
  final PublishSubject<T> _dispatch = PublishSubject();

  /// listening to the event
  BaseBloc() {
    _dispatch.listen((event) {
      handleEvent(event);
    });
  }

  void handleEvent(T event);

  /// we need to dispatch the event from the
  void dispatch(T event) {
    _logger.info("Event Dispatched: $event");
    _dispatch.add(event);
  }

  void dispose() {
    _dispatch.close();
  }
}
