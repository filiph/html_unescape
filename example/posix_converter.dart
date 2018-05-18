// Copyright (c) 2018, Filip Hracek. All rights reserved. Use of this source
// code is governed by a BSD-style license that can be found in the LICENSE
// file.

import 'dart:convert';
import 'dart:io';

import 'package:html_unescape/html_unescape.dart';

main() async {
  // Try something like
  //
  //    $ dart example/posix_converter.dart < some_file.html
  await stdin
      .transform(new Utf8Decoder())
      .transform(new HtmlUnescape())
      .transform(new Utf8Encoder())
      .pipe(stdout);
}
