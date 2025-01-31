import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final class FabScrollExposeNotifier extends ChangeNotifier {}

final fabScrollExposeNotifierProvider =
    AutoDisposeChangeNotifierProvider((ref) => FabScrollExposeNotifier());
