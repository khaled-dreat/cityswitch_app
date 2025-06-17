import 'package:cityswitch_app/core/utils/style/app_colers.dart';
import 'package:cityswitch_app/core/utils/style/app_text_style.dart';
import 'package:cityswitch_app/core/utils/widgets/app_bar/app_bar.dart';
import 'package:cityswitch_app/features/market_details/presentation/manger/cubit/market_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../../core/calculate_zoom_for_furthest_store/calculate_zoom_for_furthest_store.dart';
import '../../../../core/utils/location_service/location_service.dart';
import '../../../home/domain/entities/maps_entites.dart';
import '../../../home/presentation/manger/select_category_cubit/select_category_cubit.dart';
import '../../../home/presentation/manger/store_cubit/stors_cubit.dart';
import '../widgets/custom_now_playing_card.dart';
import '../widgets/scroll_widget.dart';

class MarketDetailsView extends StatelessWidget {
  static const String nameRoute = "MarketDetailsView";
  const MarketDetailsView({super.key});
  final List<Widget> tabs = const [MarketDetails(), OwnerDetails()];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: const Scaffold(
        body: MarketDetailsViewBody(),
        //      appBar: CustomAppBar(),
      ),
    );
  }
}

class MarketDetailsViewBody extends StatelessWidget {
  const MarketDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FeaturedNowPlayingListView(
          storsEntites: context.read<MarketDetailsCubit>().state,
        ),

        TabBar(
          indicatorColor: AppColors.greenBright,

          tabs: [
            Text(
              "Market",
              style: AppTextStyle.h2Regular24(
                context,
              ).copyWith(color: AppColors.greenBright),
            ),
            Text(
              "Owner",
              style: AppTextStyle.h2Regular24(
                context,
              ).copyWith(color: AppColors.greenBright),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [OwnerDetails(), Center(child: Text('محتوى المفضلة'))],
          ),
        ),
      ],
    );
  }
}

class OwnerDetails extends StatelessWidget {
  const OwnerDetails({super.key});
  @override
  Widget build(BuildContext context) {
    StorsEntites market = context.read<MarketDetailsCubit>().state;
    final List<String> jobTitles = ["24/7", "Delivery", "Drinks"];

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    market.name!,
                    style: AppTextStyle.h2Semibold24(
                      context,
                    ).copyWith(color: AppColors.greenDark),
                  ),
                  Wrap(
                    spacing: 10,
                    children:
                        jobTitles
                            .map(
                              (title) => Chip(
                                side: BorderSide(
                                  color: AppColors.greenBright60,
                                ),
                                label: Text(title),
                                backgroundColor: AppColors.greenBright60,
                              ),
                            )
                            .toList(),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 30,
                        color: AppColors.greenDark,
                      ),
                      Expanded(
                        child: Text(
                          "Market location in details",
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.h4Regular16(
                            context,
                          ).copyWith(color: AppColors.greenDark),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.directions_walk,
                        size: 30,
                        color: AppColors.greenDark,
                      ),
                      Text(
                        "10 Km Far away",
                        style: AppTextStyle.h4Regular16(
                          context,
                        ).copyWith(color: AppColors.greenDark),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        market.rating.toString(),
                        style: AppTextStyle.h4Medium16(
                          context,
                        ).copyWith(color: AppColors.greenDark),
                      ),
                      Icon(
                        Icons.star_rate_rounded,
                        size: 30,
                        color: AppColors.orangeDark,
                      ),
                    ],
                  ),
                  Text(
                    "Description",
                    style: AppTextStyle.h2Regular24(
                      context,
                    ).copyWith(color: AppColors.greenDark),
                  ),
                  Text(
                    market.description!,
                    style: AppTextStyle.h5Medium14(
                      context,
                    ).copyWith(color: AppColors.black),
                  ),
                  SizedBox(
                    height: 300,
                    child: MarketDetailsMap(storsEntites: market),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ],
    );
  }
}

class MarketDetailsMap extends StatefulWidget {
  const MarketDetailsMap({super.key, required this.storsEntites});
  final StorsEntites storsEntites;

  @override
  State<MarketDetailsMap> createState() => _MarketDetailsMapState();
}

class _MarketDetailsMapState extends State<MarketDetailsMap> {
  late CameraPosition initialCameraPostion;
  String? selectedCategory;
  List<StorsEntites> allStores = [];
  late LocationService locationService;
  CalculateZoomForFurthestStore calculateZoomForFurthestStore =
      CalculateZoomForFurthestStore();
  @override
  void initState() {
    initialCameraPostion = const CameraPosition(
      zoom: 6,
      target: LatLng(51.137304653951055, 10.424409714917962),
    );
    locationService = LocationService();
    updateMyLocation();
    super.initState();
  }

  GoogleMapController? googleMapController;
  Set<Marker> markers = {};
  void addStoreMarkers(String? category) async {
    markers.add(
      Marker(
        markerId: MarkerId(widget.storsEntites.id!),
        position: LatLng(
          widget.storsEntites.location!.lat!,
          widget.storsEntites.location!.lng!,
        ),
        infoWindow: InfoWindow(title: widget.storsEntites.name),
        icon: await BitmapDescriptor.asset(
          const ImageConfiguration(size: Size(48, 48)),
          'assets/img/logo/logo.png',
        ),
      ),
    );
    var loc = await locationService.getLocation();
    setMyCameraPosition(
      locationData: loc,
      zoomLivel: await calculateZoomForFurthestStore.findFurthestLocation(
        allStores,
      ),
    );
    setMyLocationMarker(loc);
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // context.read<StorsCubit>().fetchStors();

    // استمع لتحديث المتاجر
    context.read<StorsCubit>().stream.listen((state) {
      if (state is StorsSuccess) {
        allStores = state.stors;
        addStoreMarkers(context.read<StoreFilterCubit>().state);
      }
    });

    // استمع لتغيير الفئة المحددة
    context.read<StoreFilterCubit>().stream.listen((category) {
      selectedCategory = category;
      addStoreMarkers(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationButtonEnabled: true,
      markers: markers,
      onMapCreated: (controller) {
        googleMapController = controller;
      },
      initialCameraPosition: initialCameraPostion,
      cameraTargetBounds: CameraTargetBounds(
        LatLngBounds(
          southwest: LatLng(47.41209395398004, 5.985812356300719),
          northeast: LatLng(54.96404597537539, 14.934166528572108),
        ),
      ),
    );
  }

  void updateMyLocation() async {
    await locationService.checkAndRequestLocationService();
    var hasPermission =
        await locationService.checkAndRequestLocationPermission();
    if (hasPermission) {
      getMylocation();
      //     setMyCameraPosition(locationData);
      //  locationService.getRealTimeLocationData((locationData) {
      //    setMyLocationMarker(locationData);
      //  });
    } else {}
  }

  void getMylocation() async {
    var loc = await locationService.getLocation();
    setMyLocationMarker(loc);
    setMyCameraPosition(locationData: loc);
  }

  void setMyCameraPosition({
    required LocationData locationData,
    double? zoomLivel,
  }) {
    var camerPosition = CameraPosition(
      target: LatLng(locationData.latitude!, locationData.longitude!),
      zoom: zoomLivel ?? 15,
    );

    googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(camerPosition),
    );
  }

  void setMyLocationMarker(LocationData locationData) {
    var myLocationMarker = Marker(
      markerId: const MarkerId('my_location_marker'),
      position: LatLng(locationData.latitude!, locationData.longitude!),
    );

    markers.add(myLocationMarker);
    setState(() {});
  }
}

class MarketDetails extends StatelessWidget {
  const MarketDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class FeaturedNowPlayingListView extends StatefulWidget {
  const FeaturedNowPlayingListView({super.key, required this.storsEntites});

  final StorsEntites storsEntites;

  @override
  State<StatefulWidget> createState() => _FeaturedNowPlayingListViewState();
}

class _FeaturedNowPlayingListViewState
    extends State<FeaturedNowPlayingListView> {
  late final ScrollController _scrollController;
  var currentIndex = 0; // Track the current index

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    // Update current index based on the scroll position
    int newIndex =
        (_scrollController.position.pixels /
                MediaQuery.of(context).size.width *
                1.3)
            .round();
    setState(() {
      currentIndex = newIndex;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .3,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView.builder(
            controller: _scrollController,
            itemCount: widget.storsEntites.images!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width * .8,
                margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 8),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.network(
                  widget.storsEntites.images!.elementAt(index),
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          ScrollWidget(
            currentIndex: currentIndex,
            length: widget.storsEntites.images!.length,
          ),
        ],
      ),
    );
  }
}
