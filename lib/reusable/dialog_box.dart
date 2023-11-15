import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class firsta_alertdialog extends StatelessWidget {
  const firsta_alertdialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      //backgroundColor:Color.fromARGB(255, 207, 202, 202).withOpacity(0.8),
      //title: Text('Alert'),
      content: Text('Do you want to exit?',
      style: GoogleFonts.oswald(fontSize: 15, fontWeight: FontWeight.bold),),
      actions: [ 
        TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No',style: GoogleFonts.oswald(),)),
        TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Exit',style: GoogleFonts.oswald(),)),
      ],
    );
  }
}


class previous_pagedailog extends StatelessWidget {
  const previous_pagedailog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      //backgroundColor: Color.fromARGB(255, 207, 202, 202).withOpacity(0.8),
      // title: Text('Alert'),
      content: Text('Do you want to go to the previous page?',
      style: GoogleFonts.oswald(fontSize: 15, fontWeight: FontWeight.bold),),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No',style: GoogleFonts.oswald(),)),
        TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes',style: GoogleFonts.oswald(),)),
      ],
    );
  }
}