import 'package:flutter/material.dart';

class SliderBar extends StatelessWidget {
  final String mainCateName;
  const SliderBar({Key? key, required this.mainCateName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.05,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: RotatedBox(
            quarterTurns: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                mainCateName == 'Beauty'
                    ? const Text('')
                    : const Text('<<', style: style),
                Text(mainCateName.toUpperCase(), style: style),
                mainCateName == 'Men'
                    ? const Text('')
                    : const Text('>>', style: style),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const style = TextStyle(
  color: Colors.lightBlue,
  fontSize: 16,
  fontWeight: FontWeight.w600,
  letterSpacing: 10,
);
