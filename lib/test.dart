import 'package:flutter/material.dart';

class testscreen extends StatelessWidget {
  const testscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Stack(
                  children: [
                    _buildImageContainer(),
                    _buildTopButtons(context),
                    _buildCardContent(),
                  ],
                ),
              ),
            ),
            _buildButtonContainer(),
          ],
        ),
      ),
    );
  }

  // 1. Gambar Header Utama
  Widget _buildImageContainer() {
    return Container(
      width: double.infinity,
      height: 380,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/tempat/pasarbambu.webp'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // 2. Tombol Navigasi Atas (Back & More)
  Widget _buildTopButtons(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 16,
      right: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCircleIconButton(
            icon: Icons.arrow_back,
            onTap: () => Navigator.maybePop(context),
          ),
          
        ],
      ),
    );
  }

  // 3. Card Konten Utama (Warna Teal)
  Widget _buildCardContent() {
    return Container(
      margin: const EdgeInsets.only(top: 320),
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        color: Color(0xFF006D77),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Judul dan Pin Lokasi
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Desa Bonjeruk',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Lombok Tengah, Nusa Tenggara Barat',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              _buildCircleIconButton(
                icon: Icons.location_on_outlined,
                iconColor: const Color(0xFF006D77),
                bgColor: Colors.white,
                size: 40,
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Rating
          Row(
            children: [
              ...List.generate(
                5,
                (index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 18,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                '4.8',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                '(123 Reviews)',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Text Deskripsi
          _buildTextContainer(),
          const SizedBox(height: 20),

          // Galeri Foto Kecil
          _buildimageContainer2(),
        ],
      ),
    );
  }

  // 4. Widget Text Deskripsi
  Widget _buildTextContainer() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Deskripsi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text.rich(
          TextSpan(
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
              height: 1.5,
            ),
            children: [
              TextSpan(
                text:
                    'Selamat datang di Desa Bonjeruk! Desa ini memiliki keindahan alam yang memukau, budaya yang kaya, dan keramahan penduduknya... ',
              ),
              TextSpan(
                text: 'Read more',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 5. Widget Galeri Foto Samping
  Widget _buildimageContainer2() {
    final List<String> galleryImages = [
      'images/tempat/balebangket.jpg',
      'images/tempat/pasarbambu.webp',
      'images/tempat/balebangket.jpg',
    ];

    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: galleryImages.length + 1,
        itemBuilder: (context, index) {
          if (index < galleryImages.length) {
            return Container(
              width: 70,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(galleryImages[index]),
                  fit: BoxFit.cover,
                ),
              ),
            );
          } else {
            return Container(
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(galleryImages[0]),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withAlpha(150),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: const Center(
                child: Text(
                  '5+',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  // 6. Widget Tombol Bawah (Bookmark & Action Button)
  Widget _buildButtonContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      color: const Color(0xFFF2F4F7),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black12),
            ),
            child: const Icon(
              Icons.bookmark_outline,
              color: Color(0xFF006D77),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Aksi ketika tombol ditekan
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF006D77),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Jelajahi Desa Bonjeruk',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Tombol Bulat (Back, More, Location)
  Widget _buildCircleIconButton({
    required IconData icon,
    required VoidCallback onTap,
    Color bgColor = const Color(0x66000000),
    Color iconColor = Colors.white,
    double size = 40,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: size * 0.5,
        ),
      ),
    );
  }
}