import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/player_bloc.dart';
import '../controllers/player_event.dart';
import '../models/player_model.dart';

class AddPlayerView extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController gamersTagController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Player'),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 400,
            constraints: BoxConstraints(
              maxHeight: 600,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomBanner(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Enter New Player Name',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 16),
                      CustomTextField(
                        controller: nameController,
                        labelText: 'Enter Player Name',
                        maxLength: 30,
                      ),
                      SizedBox(height: 16),
                      CustomTextField(
                        controller: gamersTagController,
                        labelText: 'Enter Gamers Tag ID',
                        maxLength: 10,
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
                                final player = Player(
                                  name: nameController.text,
                                  gamersTag: gamersTagController.text,
                                  avatarUrl: 'https://via.placeholder.com/150',
                                );
                                context
                                    .read<PlayerBloc>()
                                    .add(AddPlayer(player));
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Please fill in all fields'),
                                  ),
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
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFe52d27), Color(0xFFb31217)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          'ADD PLAYER',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
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
    double cut = 20.0;
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width - cut, size.height);
    path.lineTo(cut, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final int maxLength;

  CustomTextField({
    required this.controller,
    required this.labelText,
    required this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey.withOpacity(0.5),
            Colors.grey.withOpacity(0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.black, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.3),
            spreadRadius: -5,
            blurRadius: 15,
            offset: Offset(0, 0),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 60,
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              fontWeight: FontWeight.w100,
            ),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.transparent,
            counterText: '',
          ),
          maxLength: maxLength,
        ),
      ),
    );
  }
}

class CustomConfirmButton extends StatelessWidget {
  final VoidCallback onPressed;

  CustomConfirmButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 4,
          left: 4,
          child: ClipPath(
            clipper: CustomButtonClipper(),
            child: Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
          ),
        ),
        ClipPath(
          clipper: CustomButtonClipper(),
          child: GestureDetector(
            onTap: onPressed,
            child: Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFe52d27),
                    Color(0xFFb31217),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: Colors.white,
                  width: 1.0,
                ),
              ),
              child: Center(
                child: Text(
                  'CONFIRM',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
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

class CustomCancelButton extends StatelessWidget {
  final VoidCallback onPressed;

  CustomCancelButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 2,
          left: 2,
          child: ClipPath(
            clipper: CustomButtonClipperBottomLeft(),
            child: Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ),
        ClipPath(
          clipper: CustomButtonClipperBottomLeft(),
          child: GestureDetector(
            onTap: onPressed,
            child: Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white,
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
                    fontSize: 12,
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

class CustomButtonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double cutSize = 20.0;

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - cutSize);
    path.lineTo(size.width - cutSize, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CustomButtonClipperBottomLeft extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double cutSize = 20.0;

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(cutSize, size.height);
    path.lineTo(0, size.height - cutSize);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
