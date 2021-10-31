import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopupPage extends StatelessWidget {
  const TopupPage({final Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: TopupPage());

  static Route route() => MaterialPageRoute<void>(
        builder: (final _) => const TopupPage(),
      );

  @override
  Widget build(final BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFF4F4F4),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      Text(
                        'Top up wallet',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w700, fontSize: 25),
                      ),
                    ],
                  )),
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Card(
                    color: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(11))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 8,
                            ),
                            child: Text(
                              'Enter Amount',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 18, right: 16, bottom: 20),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '\RM',
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 35),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: TextField(
                                      key: const Key(
                                          'topupPage_amount_textField'),
                                      cursorColor: Colors.cyan,
                                      keyboardType: TextInputType.number,
                                      style: GoogleFonts.roboto(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.cyan),
                                        ),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.cyan),
                                        ),
                                        hintText: 'Amount',
                                        labelStyle: GoogleFonts.roboto(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: () {},
                                  color: const Color(0xFFF4F4F4),
                                  textColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    'RM 100',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                RaisedButton(
                                  onPressed: () {},
                                  color: Color(0xFFF4F4F4),
                                  textColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text(
                                    'RM 500',
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                RaisedButton(
                                  onPressed: () {},
                                  color: const Color(0xFFF4F4F4),
                                  textColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    'RM 1000',
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RaisedButton(
                            color: Colors.white,
                            padding: const EdgeInsets.all(10),
                            elevation: 0,
                            hoverElevation: 0,
                            focusElevation: 0,
                            highlightElevation: 0,
                            onPressed: () {},
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: const BoxDecoration(
                                  color: Color(0xFF65D5E3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(11))),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: Text(
                                'Top up',
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
