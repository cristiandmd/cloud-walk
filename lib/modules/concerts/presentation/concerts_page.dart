import 'package:concerts_weather/app/design_tokens.dart';
import 'package:concerts_weather/app/routes/app_route.dart';
import 'package:concerts_weather/generated/l10n.dart';
import 'package:concerts_weather/modules/concerts/presentation/concerts_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/repositories/concert_model.dart';
import 'concerts_bloc.dart';
import 'concerts_state.dart';

class ConcertsPage extends StatefulWidget {
  const ConcertsPage({super.key, required this.bloc});
  final ConcertsBloc bloc;

  @override
  State<ConcertsPage> createState() => _ConcertsPageState();
}

class _ConcertsPageState extends State<ConcertsPage> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(LoadConcertsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(DesignTokens.large),
        child: BlocBuilder<ConcertsBloc, ConcertsState>(
          builder: (context, state) {
            return switch (state) {
              InitialConcertsState() => const SizedBox.shrink(),
              LoadingConcertsState() => const CircularProgressIndicator(),
              LoadedConcertsState() => _LoadedState(data: state.data),
              ColdNotLoadConcertsState() => Column(
                  children: [
                    const Icon(Icons.error),
                    const SizedBox(height: DesignTokens.small),
                    Text(S.current.ConcertsCouldNotLoad),
                  ],
                ),
            };
          },
        ),
      ),
    );
  }
}

class _LoadedState extends StatelessWidget {
  const _LoadedState({required this.data});
  final Iterable<ConcertModel> data;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: data.length,
      itemBuilder: (_, index) {
        final item = data.elementAt(index);
        return ListTile(
          title: Text(item.address.city),
          subtitle: Text(item.address.country),
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutesNames.concertsDetail.name,
              arguments: item,
            );
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) => Container(
        height: DesignTokens.hairline,
        color: Colors.grey,
      ),
    );
  }
}
