import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_tdd/core/common/widgets/appbar/appbar.dart';
import 'package:tiktok_tdd/core/common/widgets/loaders/search_tile.dart';
import 'package:tiktok_tdd/core/utils/constants/colors.dart';
import 'package:tiktok_tdd/core/utils/constants/sizes.dart';
import 'package:tiktok_tdd/src/search/presentation/bloc/search_user_bloc.dart';
import 'package:tiktok_tdd/src/search/presentation/widgets/searched_usertile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<SearchUserBloc>().add(ClearUsers());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: TAppBar(
          title: CupertinoSearchTextField(
            onChanged: (value) {
              if (value != "") {
                context.read<SearchUserBloc>().add(OnSearchEvent(query: value));
              } else {
                context.read<SearchUserBloc>().add(ClearUsers());
              }
            },
            backgroundColor: Colors.white,
          ),
        ),
        body: BlocConsumer<SearchUserBloc, SearchUserState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is SearchUserLoading) {
              return ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: TSizes.spaceBtwItems),
                  itemCount: 3,
                  itemBuilder: (context, index) => const SearchTileLoader());
            } else if (state is SearchUserLoaded) {
              final users = state.users;
              return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return SearchedUserTile(
                      user: users[index],
                    );
                  });
            }
            return const Center(
              child: Icon(
                Icons.search,
                color: TColors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}
