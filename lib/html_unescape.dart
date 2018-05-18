// Copyright (c) 2018, Filip Hracek. All rights reserved. Use of this source
// code is governed by a BSD-style license that can be found in the LICENSE
// file.

/// Unescapes HTML5-escaped strings.
library html_unescape;

import 'src/base.dart';
import 'src/data/named_chars_all.dart' as data;

class HtmlUnescape extends HtmlUnescapeBase {
  final int maxKeyLength = data.maxKeyLength;
  final List<String> keys = data.keys;
  final List<String> values = data.values;
}
