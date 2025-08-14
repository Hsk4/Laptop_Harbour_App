import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ViewType { list, grid }

final viewTypeProvider = StateProvider<ViewType>((ref) => ViewType.list);
