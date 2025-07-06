import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/market_details/presentation/manger/cubit/market_details_cubit.dart';

class MarketDetailsScreen extends StatefulWidget {
  static const String nameRoute = "MarketDetailsScreen";

  const MarketDetailsScreen({super.key});

  @override
  _MarketDetailsScreenState createState() => _MarketDetailsScreenState();
}

class _MarketDetailsScreenState extends State<MarketDetailsScreen> {
  int _currentIndex = 0;
  int _selectedStars = 0;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MarketDetailsCubit marketDetailsCubit = BlocProvider.of<MarketDetailsCubit>(
      context,
    );

    return Scaffold(
      backgroundColor: Colors.grey[50],

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Market Image with dots indicator
            Container(
              height: 200,
              child: Stack(
                children: [
                  PageView.builder(
                    itemCount: 5,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              '${marketDetailsCubit.state.images![index]}',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                _currentIndex == index
                                    ? Colors.blue
                                    : Colors.grey[300],
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),

            // Tab Bar
            Container(
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                      child: Text(
                        'Market',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'Owner',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Market Name
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Market Name',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      _buildJobTitleChip('Jop Title'),
                      SizedBox(width: 8),
                      _buildJobTitleChip('Jop Title'),
                      SizedBox(width: 8),
                      _buildJobTitleChip('Jop Title'),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.grey[600],
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Market location in details',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.near_me, color: Colors.grey[600], size: 16),
                      SizedBox(width: 4),
                      Text(
                        '10 Km Far away',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 16),
                      SizedBox(width: 4),
                      Text('4.5', style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 8),

            // Description
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Lorem ipsum dolor sit amet consectetur. Nisl rhoncus amet sit luctus orci diam sit interdum. Sit amet nisl risus placerat. Non elit...',
                    style: TextStyle(color: Colors.grey[600], height: 1.4),
                  ),
                ],
              ),
            ),

            SizedBox(height: 8),

            // Location
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Map View',
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 8),

            // Reviews
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reviews',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                  SizedBox(height: 12),
                  ...List.generate(4, (index) => _buildReviewCard()),
                ],
              ),
            ),

            SizedBox(height: 8),

            // Write Review
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Write Review',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Your Name',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: _reviewController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Write your review',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedStars = index + 1;
                          });
                        },
                        child: Icon(
                          Icons.star,
                          color:
                              index < _selectedStars
                                  ? Colors.orange
                                  : Colors.grey[300],
                          size: 30,
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle submit
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildJobTitleChip(String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Text(
        title,
        style: TextStyle(color: Colors.blue[700], fontSize: 12),
      ),
    );
  }

  Widget _buildReviewCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue[200]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[300],
            child: Icon(Icons.person, color: Colors.grey[600]),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ahmed Amer',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(Icons.star, color: Colors.orange, size: 14);
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  'Lorem ipsum dolor sit amet consectetur. Nisl rhoncus amet sit luctus orci diam sit interdum.',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'البحث عن المتاجر',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Cairo',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StoreSearchScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StoreSearchScreen extends StatefulWidget {
  @override
  _StoreSearchScreenState createState() => _StoreSearchScreenState();
}

class _StoreSearchScreenState extends State<StoreSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedCategory;
  String? _selectedCity;
  List<Store> _filteredStores = [];
  List<Store> _allStores = [];

  final List<String> _categories = [
    'جميع الفئات',
    'مطاعم',
    'مقاهي',
    'متاجر ملابس',
    'صيدليات',
    'سوبر ماركت',
    'إلكترونيات',
  ];

  final List<String> _cities = [
    'جميع المدن',
    'الرياض',
    'جدة',
    'الدمام',
    'مكة المكرمة',
    'المدينة المنورة',
    'الطائف',
  ];

  @override
  void initState() {
    super.initState();
    _initializeStores();
    _filteredStores = _allStores;
  }

  void _initializeStores() {
    _allStores = [
      Store(
        name: 'مطعم الذواقة',
        category: 'مطاعم',
        city: 'الرياض',
        address: 'شارع الملك فهد، الرياض',
        rating: 4.5,
        isOpen: true,
        latitude: 24.7136,
        longitude: 46.6753,
      ),
      Store(
        name: 'مقهى الكورنيش',
        category: 'مقاهي',
        city: 'جدة',
        address: 'كورنيش جدة، جدة',
        rating: 4.2,
        isOpen: true,
        latitude: 21.4858,
        longitude: 39.1925,
      ),
      Store(
        name: 'صيدلية النهدي',
        category: 'صيدليات',
        city: 'الدمام',
        address: 'شارع الأمير محمد بن فهد، الدمام',
        rating: 4.0,
        isOpen: false,
        latitude: 26.4207,
        longitude: 50.0888,
      ),
      Store(
        name: 'مول العرب',
        category: 'متاجر ملابس',
        city: 'الرياض',
        address: 'حي الملقا، الرياض',
        rating: 4.3,
        isOpen: true,
        latitude: 24.7471,
        longitude: 46.6437,
      ),
      Store(
        name: 'كافيه لافندر',
        category: 'مقاهي',
        city: 'جدة',
        address: 'شارع التحلية، جدة',
        rating: 4.7,
        isOpen: true,
        latitude: 21.5169,
        longitude: 39.1748,
      ),
    ];
  }

  void _performSearch() {
    String searchTerm = _searchController.text.toLowerCase().trim();

    setState(() {
      _filteredStores =
          _allStores.where((store) {
            bool matchesSearch =
                searchTerm.isEmpty ||
                store.name.toLowerCase().contains(searchTerm) ||
                store.address.toLowerCase().contains(searchTerm);

            bool matchesCategory =
                _selectedCategory == null ||
                _selectedCategory == 'جميع الفئات' ||
                store.category == _selectedCategory;

            bool matchesCity =
                _selectedCity == null ||
                _selectedCity == 'جميع المدن' ||
                store.city == _selectedCity;

            return matchesSearch && matchesCategory && matchesCity;
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'البحث عن المتاجر',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[800],
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: TextField(
                      controller: _searchController,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintText: 'ابحث عن المتاجر...',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        prefixIcon: Icon(Icons.search, color: Colors.blue[800]),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                      onChanged: (value) => _performSearch(),
                    ),
                  ),
                  SizedBox(height: 12),
                  // Dropdown Lists
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedCategory,
                              hint: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'اختر الفئة',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                              isExpanded: true,
                              items:
                                  _categories.map((String category) {
                                    return DropdownMenuItem<String>(
                                      value: category,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        child: Text(
                                          category,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedCategory = newValue;
                                });
                                _performSearch();
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedCity,
                              hint: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'اختر المدينة',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                              isExpanded: true,
                              items:
                                  _cities.map((String city) {
                                    return DropdownMenuItem<String>(
                                      value: city,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        child: Text(
                                          city,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedCity = newValue;
                                });
                                _performSearch();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Results Section
          Expanded(
            child:
                _filteredStores.isEmpty
                    ? _buildEmptyState()
                    : Column(
                      children: [
                        // Map Section
                        Container(
                          height: 200,
                          margin: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: _buildMapPlaceholder(),
                          ),
                        ),
                        // Store List
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                              left: 16,
                              right: 16,
                              bottom: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[50],
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'النتائج (${_filteredStores.length})',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue[800],
                                        ),
                                      ),
                                      Icon(
                                        Icons.store,
                                        color: Colors.blue[800],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: _filteredStores.length,
                                    itemBuilder: (context, index) {
                                      return _buildStoreCard(
                                        _filteredStores[index],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 80, color: Colors.grey[400]),
          SizedBox(height: 16),
          Text(
            'لا توجد نتائج',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'جرب تعديل معايير البحث',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildMapPlaceholder() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey[200],
      child: Stack(
        children: [
          // Map background pattern
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://via.placeholder.com/400x200/E3F2FD/2196F3?text=الخريطة',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Map markers
          ...List.generate(_filteredStores.length, (index) {
            return Positioned(
              top: 40 + (index * 20.0) % 100,
              left: 50 + (index * 30.0) % 300,
              child: Icon(Icons.location_on, color: Colors.red, size: 24),
            );
          }),
          // Map info overlay
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'يظهر ${_filteredStores.length} متجر',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                  Icon(Icons.map, size: 16, color: Colors.blue[800]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreCard(Store store) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // Handle store tap
          _showStoreDetails(store);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              // Store Icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(
                  _getStoreIcon(store.category),
                  color: Colors.blue[800],
                  size: 24,
                ),
              ),
              SizedBox(width: 16),
              // Store Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          store.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color:
                                store.isOpen
                                    ? Colors.green[100]
                                    : Colors.red[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            store.isOpen ? 'مفتوح' : 'مغلق',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color:
                                  store.isOpen
                                      ? Colors.green[800]
                                      : Colors.red[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      store.category,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            store.address,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < store.rating.floor()
                                  ? Icons.star
                                  : Icons.star_border,
                              size: 14,
                              color: Colors.amber[600],
                            );
                          }),
                        ),
                        SizedBox(width: 8),
                        Text(
                          store.rating.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getStoreIcon(String category) {
    switch (category) {
      case 'مطاعم':
        return Icons.restaurant;
      case 'مقاهي':
        return Icons.local_cafe;
      case 'متاجر ملابس':
        return Icons.shopping_bag;
      case 'صيدليات':
        return Icons.local_pharmacy;
      case 'سوبر ماركت':
        return Icons.shopping_cart;
      case 'إلكترونيات':
      //    return Icons.electronics;
      default:
        return Icons.store;
    }
  }

  void _showStoreDetails(Store store) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    store.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.category, color: Colors.blue[800]),
                  SizedBox(width: 8),
                  Text(
                    store.category,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_city, color: Colors.blue[800]),
                  SizedBox(width: 8),
                  Text(
                    store.city,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.location_on, color: Colors.blue[800]),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      store.address,
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Handle navigation
                    },
                    icon: Icon(Icons.directions),
                    label: Text('الاتجاهات'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                      foregroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: () {
                      // Handle call
                    },
                    icon: Icon(Icons.phone),
                    label: Text('اتصال'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue[800],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class Store {
  final String name;
  final String category;
  final String city;
  final String address;
  final double rating;
  final bool isOpen;
  final double latitude;
  final double longitude;

  Store({
    required this.name,
    required this.category,
    required this.city,
    required this.address,
    required this.rating,
    required this.isOpen,
    required this.latitude,
    required this.longitude,
  });
}

/*
import 'dart:developer';

import 'package:cityswitch_app/features/add_market/presentation/manger/add_store/add_store_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'features/add_market/data/models/search_addresses/search_addresses.dart';

class AddressSearchScreen extends StatefulWidget {
  @override
  _AddressSearchScreenState createState() => _AddressSearchScreenState();
}

class _AddressSearchScreenState extends State<AddressSearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (searchController.text.length >= 2) {
      _searchAddresses(searchController.text);
    }
  }

  Future<void> _searchAddresses(String query) async {
    AddStoreCubit cAddStore = BlocProvider.of<AddStoreCubit>(context);
    cAddStore.fetchSearchAddresses(endPoint: query);
  }

  void _onSuggestionSelected(SearchAddressesModel suggestion) {
    searchController.text =
        '${suggestion.address!.city!} ${suggestion.address!.postcode}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddStoreCubit, AddStoreState>(
      builder: (context, state) {
        return Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // Search field
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search for city or postal code...',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    prefixIcon: Icon(Icons.search, color: Colors.blue[600]),
                    suffixIcon:
                        (state is SearchAddressesLoading)
                            ? Padding(
                              padding: EdgeInsets.all(12),
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.blue[600]!,
                                  ),
                                ),
                              ),
                            )
                            : searchController.text.isNotEmpty
                            ? IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                searchController.clear();
                                //  setState(() {
                                //    suggestions = [];
                                //    markers = {};
                                //  });
                              },
                            )
                            : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),

              // Suggestions list
              if (state is SearchAddressesSuccess)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  constraints: BoxConstraints(maxHeight: 300),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      log(
                        state.searchAddressesModel
                            .elementAt(index.bitLength)
                            .address!
                            .city
                            .toString(),
                      );
                      return CustomSearchItemList(
                        searchAddressesModel: state.searchAddressesModel
                            .elementAt(index),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

class CustomSearchItemList extends StatelessWidget {
  const CustomSearchItemList({super.key, required this.searchAddressesModel});
  final SearchAddressesModel searchAddressesModel;
  @override
  Widget build(BuildContext context) {
    return searchAddressesModel.address!.postcode != null
        ? ListTile(
          leading: Icon(Icons.location_on, color: Colors.red[400]),
          title: Text(
            searchAddressesModel.address!.cityDistrict ??
                searchAddressesModel.address!.city.toString(),
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          subtitle: Text(
            searchAddressesModel.address!.postcode.toString(),
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey[400],
          ),
          //   onTap: () => _onSuggestionSelected(state.searchAddressesModel.first),
          dense: true,
        )
        : SizedBox();
  }
}
*/
*/
