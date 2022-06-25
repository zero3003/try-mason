import 'dart:async';

Timer? _debounce;

///don't forget to dispose it, okay?
void debounce(Function callback) async {
  if (_debounce?.isActive ?? false) _debounce?.cancel();
  _debounce = Timer(const Duration(milliseconds: 300), () => callback());
}

///dispose after use
void disposeDebounce() {
  if (_debounce?.isActive ?? false) _debounce?.cancel();
}
