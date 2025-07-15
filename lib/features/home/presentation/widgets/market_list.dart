import 'dart:developer';

import 'package:cityswitch_app/features/home/presentation/manger/store_cubit/stors_cubit.dart';
import 'package:cityswitch_app/features/home/presentation/manger/fetch_stores_categories_cubit/stores_categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/style/app_colers.dart';
import '../../../../core/utils/style/app_text_style.dart';
import 'market_card.dart';

class MarketList extends StatelessWidget {
  const MarketList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StorsCubit, StorsState>(
      builder: (context, state) {
        if (state is StorsSuccess) {
          if (state.stors.isEmpty) {
            return Container(
              padding: const EdgeInsets.all(8.0),

              alignment: Alignment.center,
              height: MediaQuery.sizeOf(context).height * 0.39,
              child: Text(
                "No Stores !!!",
                style: AppTextStyle.h1Medium28(
                  context,
                ).copyWith(color: AppColors.greenDark),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Stores',
                    style: AppTextStyle.h2Regular24(
                      context,
                    ).copyWith(color: AppColors.greenDark),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                  child: Text(
                    'Store ${state.stors.length}',
                    style: AppTextStyle.h5Regular14(
                      context,
                    ).copyWith(color: AppColors.greenDark),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.3,
                  child: GridView.builder(
                    itemCount: state.stors.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, // عمودين
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 1.90, // تحكم في حجم البطاقة
                    ),
                    itemBuilder: (context, index) {
                      return MarketCard(
                        storsEntites: state.stors.elementAt(index),
                        marketName: state.stors.elementAt(index).name!,
                        jobTitles: ['Jop Title', 'Jop Title', 'Jop Title'],
                        location: 'Market location in details',
                        distanceKm: 10,
                        rating: 4.5,
                        imageUrl:
                            'http://192.168.0.80:3000/${state.stors.elementAt(index).images!.first}',
                        userName: 'Ahmed Amer',
                        isOpen: true,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is StorsFailure) {
          log(state.errMessage);
        } else if (state is StorsLoading) {
          return Container(
            alignment: Alignment.center,
            height: MediaQuery.sizeOf(context).height * 0.39,
            child: CircularProgressIndicator(color: Colors.white),
          );
        }
        return SizedBox();
      },
    );
  }
}
