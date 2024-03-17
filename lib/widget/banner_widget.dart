import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({Key? key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int showedIndex = 0;

  final banners = [
    "assets/images/car1.png",
    "assets/images/car2.png",
    "assets/images/car3.png",
    'assets/images/car4.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 0, 0, 0), 
          width: 5, 
        ),
        borderRadius: BorderRadius.circular(10), 
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            CarouselSlider.builder(
              itemCount: banners.length,
              options: CarouselOptions(
                initialPage: showedIndex,
                viewportFraction: 1,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    showedIndex = index;
                  });
                },
              ),
              itemBuilder: (context, index, _) {
                return Image(
                  image: AssetImage(
                    banners[index],
                  ),
                  fit: BoxFit.fill,
                );
              },
            ),
            Positioned(
              left: 16,
              bottom: 16,
              child: Row(
                children: List.generate(
                  banners.length,
                  (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: showedIndex == index ? 24 : 10,
                      height: 10,
                      margin: const EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                        color: showedIndex == index
                            ? Theme.of(context).primaryColor
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(50),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
