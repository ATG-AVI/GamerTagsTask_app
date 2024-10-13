import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/player_bloc.dart';
import '../models/player_model.dart';

class AddPlayerView extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController gamersTagController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 400, // Set a fixed width to make it more rectangular
            constraints: BoxConstraints(
              maxHeight:
                  600, // Set a maximum height to maintain the rectangular shape
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomBanner(), // Use the CustomBanner widget here
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Enter New Player Name',
                        style: TextStyle(fontSize: 20), // Increased font size
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: 300, // Decreased width
                        margin: const EdgeInsets.symmetric(
                            horizontal:
                                16.0), // Add margin to increase horizontal space
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey.withOpacity(0.5),
                              Colors.grey.withOpacity(0.5)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.black, width: 2.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white
                                  .withOpacity(0.3), // Reduced opacity
                              spreadRadius: -5, // Reduced spread radius
                              blurRadius: 15, // Reduced blur radius
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        height: 60, // Adjust height as needed
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: 'Enter Player Name',
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight
                                      .w100), // Make the text very thin
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors
                                  .transparent, // Make the TextField background transparent
                              counterText: '', // Remove the character counter
                            ),
                            maxLength: 30,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: 300, // Decreased width
                        margin: const EdgeInsets.symmetric(
                            horizontal:
                                16.0), // Add margin to increase horizontal space
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.red.withOpacity(0.5),
                              Colors.redAccent.withOpacity(0.5)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.black, width: 2.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white
                                  .withOpacity(0.3), // Reduced opacity
                              spreadRadius: -5, // Reduced spread radius
                              blurRadius: 15, // Reduced blur radius
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        height: 60, // Adjust height as needed
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            controller: gamersTagController,
                            decoration: InputDecoration(
                              labelText: 'Enter Gamers Tag ID',
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight
                                      .w100), // Make the text very thin
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors
                                  .transparent, // Make the TextField background transparent
                              counterText: '', // Remove the character counter
                            ),
                            maxLength: 10,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomCancelButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          CustomConfirmButton(
                            onPressed: () {
                              if (nameController.text.isNotEmpty &&
                                  gamersTagController.text.isNotEmpty) {
                                final player = PlayerModel(
                                  name: nameController.text,
                                  gamersTag: gamersTagController.text,
                                  avatarUrl: 'https://via.placeholder.com/150',
                                );
                                context
                                    .read<PlayerBloc>()
                                    .add(AddPlayer(player));
                                Navigator.pop(context);
                              } else {
                                // Show an error message if fields are empty
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Please fill in all fields')),
                                );
                              }
                            },
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
      ),
    );
  }
}

class CustomBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BannerClipper(),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 10, horizontal: 50), // Increased horizontal padding
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFe52d27),
              Color(0xFFb31217)
            ], // gradient similar to the image
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          'ADD PLAYER',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14, // Reduced font size
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}

class BannerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double cut = 20.0; // the cut at the corners
    path.moveTo(0, 0); // Top-left
    path.lineTo(size.width, 0); // Top-right
    path.lineTo(size.width - cut, size.height); // Bottom-right
    path.lineTo(cut, size.height); // Bottom-left
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

// CustomConfirmButton Widget
class CustomConfirmButton extends StatelessWidget {
  final VoidCallback onPressed;

  CustomConfirmButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Outer black border
        Positioned(
          top: 4, // Increased space between the red and white outline
          left: 4, // Increased space between the red and white outline
          child: ClipPath(
            clipper: CustomButtonClipper(),
            child: Container(
              width: 100, // Further decreased width
              height: 30, // Further decreased height
              decoration: BoxDecoration(
                color: Colors.black, // Black outline
              ),
            ),
          ),
        ),
        // Main button with white outline
        ClipPath(
          clipper: CustomButtonClipper(),
          child: GestureDetector(
            onTap: onPressed,
            child: Container(
              width: 100, // Further decreased width
              height: 30, // Further decreased height
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFe52d27), // Top-left color
                    Color(0xFFb31217), // Bottom-right color
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: Colors.white, // White outline
                  width: 1.0, // Decreased thickness of the white outline
                ),
              ),
              child: Center(
                child: Text(
                  'CONFIRM',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12, // Further adjusted font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// CustomCancelButton Widget
class CustomCancelButton extends StatelessWidget {
  final VoidCallback onPressed;

  CustomCancelButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Outer border shadow
        Positioned(
          top: 2,
          left: 2,
          child: ClipPath(
            clipper: CustomButtonClipperBottomLeft(),
            child: Container(
              width: 100, // Further decreased width
              height: 30, // Further decreased height
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ),
        // Main button
        ClipPath(
          clipper: CustomButtonClipperBottomLeft(),
          child: GestureDetector(
            onTap: onPressed,
            child: Container(
              width: 100, // Further decreased width
              height: 30, // Further decreased height
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white, // Top-left color
                    Colors.white, // Bottom-right color
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              child: Center(
                child: Text(
                  'CANCEL',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12, // Further adjusted font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// CustomClipper for cutting the bottom-right corner
class CustomButtonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double cutSize = 20.0; // Size of the bottom-right cut

    path.moveTo(0, 0); // Top-left corner
    path.lineTo(size.width, 0); // Top-right corner
    path.lineTo(size.width, size.height - cutSize); // Right side down
    path.lineTo(size.width - cutSize, size.height); // Bottom-right corner cut
    path.lineTo(0, size.height); // Bottom-left corner
    path.close(); // Complete the path

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

// CustomClipper for cutting the bottom-left corner
class CustomButtonClipperBottomLeft extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double cutSize = 20.0; // Size of the bottom-left cut

    path.moveTo(0, 0); // Top-left corner
    path.lineTo(size.width, 0); // Top-right corner
    path.lineTo(size.width, size.height); // Bottom-right corner
    path.lineTo(cutSize, size.height); // Bottom-left corner cut
    path.lineTo(0, size.height - cutSize); // Left side up
    path.close(); // Complete the path

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
