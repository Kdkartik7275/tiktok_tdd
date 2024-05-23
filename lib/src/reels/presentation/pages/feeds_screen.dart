import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_tdd/core/common/widgets/loaders/reel_loader.dart';
import 'package:tiktok_tdd/src/reels/presentation/bloc/reels/reels_bloc.dart';
import 'package:tiktok_tdd/src/reels/presentation/widget/reel_widget.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ReelsBloc>().add(OnHomeInit());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ReelsBloc>().add(OnReelsScreenReturned());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ReelsBloc, ReelsState>(
          listener: (context, state) {},
          buildWhen: (previous, current) => current is! ReelsActionState,
          builder: (context, state) {
            if (state is ReelsFaliure) {
              return Center(
                child: Text(state.error),
              );
            } else if (state is ReelsLoaded) {
              return PageView.builder(
                scrollDirection: Axis.vertical,
                controller: PageController(viewportFraction: 1),
                itemCount: state.reels.length,
                itemBuilder: (context, index) {
                  final reel = state.reels[index];
                  return ReelWidget(reel: reel);
                },
              );
            }
            return const ReelLoader();
          }),
    );
  }
}
