// Copyright (c) 2018, Filip Hracek. All rights reserved. Use of this source
// code is governed by a BSD-style license that can be found in the LICENSE
// file.

/// Unescapes HTML5-escaped strings. This version doesn't support all runes
/// to decrease code size and increase performance.
library html_unescape.small;

import 'src/base.dart';
import 'src/data/named_chars_basic.dart' as data;

class HtmlUnescape extends HtmlUnescapeBase {
  final int maxKeyLength = data.maxKeyLength;
  final List<String> keys = data.keys;
  final List<String> values = data.values;
}
