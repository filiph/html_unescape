// Copyright (c) 2016, Filip Hracek. All rights reserved. Use of this source
// code is governed by a BSD-style license that can be found in the LICENSE
// file.
library html_unescape.base;

import 'dart:convert';
import 'dart:math';

abstract class HtmlUnescapeBase extends Converter<String, String> {
  int _chunkLength;
  static int _minDecimalEscapeLength = 4; // &#0;
  static int _minHexadecimalEscapeLength = 5; // &#x0;
  final int _hashCodeUnit = '#'.codeUnitAt(0);
  final int _xCodeUnit = 'x'.codeUnitAt(0);

  List<String> get keys;
  List<String> get values;
  int get maxKeyLength;

  HtmlUnescapeBase() {
    _chunkLength = max(maxKeyLength, _minHexadecimalEscapeLength);
  }

  /// Converts from HTML-escaped [data] to unescaped string.
  String convert(String data) {
    // Return early if possible.
    if (data.indexOf('&') == -1) return data;

    StringBuffer buf = new StringBuffer();
    int offset = 0;

    while (true) {
      int nextAmp = data.indexOf('&', offset);
      if (nextAmp == -1) {
        // Rest of string.
        buf.write(data.substring(offset));
        break;
      }
      buf.write(data.substring(offset, nextAmp));
      offset = nextAmp;

      var chunk =
          data.substring(offset, min(data.length, offset + _chunkLength));

      // Try &#123; and &#xff;
      if (chunk.length > _minDecimalEscapeLength &&
          chunk.codeUnitAt(1) == _hashCodeUnit) {
        int nextSemicolon = chunk.indexOf(';');
        if (nextSemicolon != -1) {
          var hex = chunk.codeUnitAt(2) == _xCodeUnit;
          var str = chunk.substring(hex ? 3 : 2, nextSemicolon);
          int ord = int.parse(str, radix: hex ? 16 : 10, onError: (_) => -1);
          if (ord != -1) {
            buf.write(new String.fromCharCode(ord));
            offset += nextSemicolon + 1;
            continue;
          }
        }
      }

      // Try &nbsp;
      var replaced = false;
      for (int i = 0; i < keys.length; i++) {
        var key = keys[i];
        if (chunk.startsWith(key)) {
          var replacement = values[i];
          buf.write(replacement);
          offset += key.length;
          replaced = true;
          break;
        }
      }
      if (!replaced) {
        buf.write('&');
        offset += 1;
      }
    }

    return buf.toString();
  }
}
