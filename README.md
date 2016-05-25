# html_unescape

A Dart library for unescaping HTML-encoded strings. 

Supports:

* Named Character References (`&nbsp`)
* Decimal Character Reference (`&#225;`)
* Hexadecimal Character Reference (`&#xE3`)

## Usage

A simple usage example:

```dart
import 'package:html_unescape/html_unescape.dart';

main() {
  var unescape = new HtmlUnescape();
  var text = unescape.convert("&lt;strong&#62;This &quot;escaped&quot; string");
  print(text);
}
```

If you're sure you will only encounter the most common escaped characters,
you can `import 'package:html_unescape/html_unescape_basic.dart'` instead of
the full version. This will decrease code size and increase performance. The
only difference is in the size of the Named Character Reference dictionary.
The full set includes the likes of `&DownLeftRightVector;` or `&UpArrowBar;`.
