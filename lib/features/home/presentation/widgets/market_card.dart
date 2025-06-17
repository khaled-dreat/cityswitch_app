import 'package:cityswitch_app/core/utils/routes/app_routes.dart';
import 'package:cityswitch_app/features/home/domain/entities/maps_entites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../market_details/presentation/manger/cubit/market_details_cubit.dart';
import '../../../market_details/presentation/pages/market_details_view.dart';

class MarketCard extends StatelessWidget {
  final String marketName;
  final List<String> jobTitles;
  final String location;
  final double distanceKm;
  final double rating;
  final String imageUrl;
  final String userName;
  final bool isOpen;

  final StorsEntites storsEntites;

  const MarketCard({
    super.key,
    required this.marketName,
    required this.jobTitles,
    required this.location,
    required this.distanceKm,
    required this.rating,
    required this.imageUrl,
    required this.userName,
    this.isOpen = true,
    required this.storsEntites,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        context.read<MarketDetailsCubit>().selectedMarketDetails(
          storsEntites: storsEntites,
        );
        AppRoutes.go(context, MarketDetailsView.nameRoute);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.green),
        ),
        child: Column(
          children: [
            // صورة السوق
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  imageUrl,
                  width: MediaQuery.sizeOf(context).width,
                  //   height: 160,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Expanded(
              //   flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      marketName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                    SizedBox(height: 8),
                    //       Row(
                    //         spacing: 6,
                    //         children:
                    //             jobTitles
                    //                 .map(
                    //                   (title) => Chip(
                    //                     label: Text(title),
                    //                     padding: EdgeInsets.all(0),
                    //                   ),
                    //                 )
                    //                 .toList(),
                    //       ),
                    SizedBox(height: 8),
                    //   Row(
                    //     children: [
                    //       Icon(Icons.location_on, size: 16, color: Colors.green),
                    //       SizedBox(width: 4),
                    //       Expanded(
                    //         child: Text(location, overflow: TextOverflow.ellipsis),
                    //       ),
                    //     ],
                    //   ),
                    Row(
                      children: [
                        Icon(
                          Icons.directions_walk,
                          size: 16,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 4),
                        Text('$distanceKm Km Far away'),
                        SizedBox(width: 8),
                        if (isOpen)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Open',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(
                      '$rating ★',
                      style: TextStyle(color: Colors.orange[800]),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundImage: NetworkImage(
                            "https://randomuser.me/api/portraits/men/1.jpg",
                          ),
                        ),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            userName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Icon(Icons.message_outlined),
                        SizedBox(width: 8),
                        Icon(Icons.share),
                        SizedBox(width: 8),
                        Icon(Icons.favorite_border),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
