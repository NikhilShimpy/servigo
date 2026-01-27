import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// home pa
class HomePage extends StatelessWidget {
  final List<ServiceCategory> categories = [
    ServiceCategory(
      title: "Women's Salon",
      image: AssetImage('assets/women_salon.png'), // Image instead of icon
      color: Colors.pink[100],
    ),
    ServiceCategory(
      title: "Men's Salon & Massage",
      icon: Icons.cut,
      color: Colors.blue[100],
    ),
    ServiceCategory(
      title: "AC & Appliance",
      icon: Icons.ac_unit,
      color: Colors.cyan[100],
    ),
    ServiceCategory(
      title: "Cleaning",
      icon: Icons.cleaning_services,
      color: Colors.green[100],
    ),
    ServiceCategory(
      title: "Plumbers & Electricians",
      icon: Icons.plumbing,
      color: Colors.orange[100],
    ),
    ServiceCategory(
      title: "Water Purifier",
      icon: Icons.water_drop,
      color: Colors.blue[200],
    ),
  ];


  final List<PromoBanner> promoBanners = [
    PromoBanner(
      title: "Shine your bathroom deserves",
      buttonText: "Book now",
      color: Colors.indigo[100]!,
    ),
    PromoBanner(
      title: "AC Service at ₹499",
      buttonText: "Avail offer",
      color: Colors.teal[100]!,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "32, Ranjeet Hanuman Rd - Dravid Naga...",
              style: TextStyle(fontSize: 14),
            ),
            Text(
              "ServiGo",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: ServiceSearchDelegate());
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search for 'Facial'",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: EdgeInsets.symmetric(vertical: 0),
              ),
              onTap: () {
                showSearch(context: context, delegate: ServiceSearchDelegate());
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Categories Grid
            Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.9,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return ServiceCategoryCard(category: categories[index]);
                },
              ),
            ),

            // Promo Banners
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: promoBanners.map((banner) {
                  return PromoBannerCard(banner: banner);
                }).toList(),
              ),
            ),

            // Popular Services
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Popular Services",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ServiceCard(
                          title: "Full Body Massage",
                          price: "₹999",
                          image: "assets/massage_logo.png",
                        ),
                        ServiceCard(
                          title: "Haircut & Shave",
                          price: "₹299",
                          image: "assets/barber_men.png",
                        ),
                        ServiceCard(
                          title: "Bathroom Deep Cleaning",
                          price: "₹799",
                          image: "assets/cleaning.png",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Bookings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

class ServiceSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text("Results for $query"),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text("Search for services"),
    );
  }
}

class ServiceCategory {
  final String title;
  final IconData? icon;
  final ImageProvider? image;
  final Color? color;

  ServiceCategory({
    required this.title,
    this.icon,
    this.image,
    this.color,
  });
}

class ServiceCategoryCard extends StatelessWidget {
  final ServiceCategory category;

  const ServiceCategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Navigate to service page
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: category.color ?? Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: category.image != null
                    ? Image(
                  image: category.image!,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                )
                    : Icon(
                  category.icon,
                  size: 24,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                category.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class PromoBanner {
  final String title;
  final String buttonText;
  final Color color;

  PromoBanner({
    required this.title,
    required this.buttonText,
    required this.color,
  });
}

class PromoBannerCard extends StatelessWidget {
  final PromoBanner banner;

  const PromoBannerCard({required this.banner});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: banner.color,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    banner.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // replaces `primary`
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(banner.buttonText),
                  ),
                ],
              ),
            ),
            Image.asset(
              "assets/banner_image.png",
              height: 80,
              width: 80,
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final String price;
  final String image;

  const ServiceCard({
    required this.title,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                image,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    price,
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
