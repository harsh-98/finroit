import 'package:flutter/material.dart';
import '../utils/bigtext.dart';
class Banner extends StatefulWidget {
  const Banner({super.key});
  // var current = WordPair.random();

  @override
  State<Banner> createState() => _AppState();
}

// class Loading extends StatelessWidget {
//   const Loading({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             CircularProgressIndicator(),
//             SizedBox(height: 20),
//             Text('Loading...'),
//           ],
//         ),
//       ),
//     );
//   }
// }

class _AppState extends State<Banner> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  late final Animation<AlignmentGeometry> _animation = Tween<AlignmentGeometry>(
    begin: Alignment(-1, -.3),
    end: Alignment(-0.33, -.3),
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.decelerate));
  late final Animation<AlignmentGeometry> _animation2 =
      Tween<AlignmentGeometry>(
        begin: Alignment(1, -.3),
        end: Alignment(.33, -.3),
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.decelerate));

  // Start the animation automatically
  // _controller.forward();

  // @override
  // void initState() {
  //   super.initState();
  //   log("here");
  // }
  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // setState
  @override
  Widget build(BuildContext context) {
    // Future.delayed(const Duration(seconds: 2)).then((value) => {
    // if (mounted) {
    //   Navigator.pushReplacementNamed(context, '/trade'),
    // }
    // });
    // appState.start = false;
    return Scaffold(
      // backgroundColor: Colors.deepPurple[0],
      body:
          // Center(
          Container(
            width: double.infinity,
            height: double.infinity,
            // alignment: Alignment(0,-0.3),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(0xff, 0x3A, 0x4A, 0xEA),
                  Color.fromARGB(0xff, 0x8B, 0x8A, 0xF5),
                  Color.fromARGB(0xff, 0x3A, 0x4A, 0xEA),
                ],
              ),
            ),
            child: Stack(
              children: [
                AlignTransition(
                  alignment: _animation,
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                    width: 60,
                    height: 60,
                  ),
                ),
                AlignTransition(
                  alignment: _animation2,
                  child: bigText('FinRoit', Colors.white),
                  ),
              ],
              // child: AlignTransition(
              //       alignment:_animation,
              //       child: Image(image: AssetImage('assets/images/logo.png'), width: 60, height: 60),
              //     ),
              // )
            ),
          ),
    );
  }
}
