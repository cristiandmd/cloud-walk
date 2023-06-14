import 'package:concerts_weather/modules/concerts/data/in_memory_concerts_repository.dart';
import 'package:concerts_weather/modules/concerts/domain/fetch_concerts_use_case.dart';
import 'package:concerts_weather/modules/concerts/presentation/concerts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/concerts_bloc.dart';

final class ConcertsFactory {
  Widget build() {
    final repository = InMemoryConcertsRepository();
    final useCase = FetchConcertsUseCase(repository: repository);
    final bloc = ConcertsBloc(useCase);

    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => bloc)],
      child: ConcertsPage(bloc: bloc),
    );
  }
}
