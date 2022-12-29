import '../components/drinkselect_widget.dart';
import '../components/slider_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../settings/settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watetlo/history.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watetlo/premiumpage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MoreoptionsWidget extends StatefulWidget {
  const MoreoptionsWidget({Key? key}) : super(key: key);

  @override
  _MoreoptionsWidgetState createState() => _MoreoptionsWidgetState();
}

class _MoreoptionsWidgetState extends State<MoreoptionsWidget> {
  double _currentSliderValue = FFAppState().cup.toDouble();

  InterstitialAd? interstitialAdHist;

  int adCounter = 0;

  adActionsSet(int action) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('adactioncount', action);
  }

  bool adsonline = true;
  adActionsGet() async {
    final prefs = await SharedPreferences.getInstance();
    adCounter = prefs.getInt('adactioncount') ?? 0;
    int? prem = prefs.getInt('premium');

    if (prem == 1) {
      setState(() {
        adsonline = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    adActionsGet();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        color: Color(0xFF003366),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: Align(
              alignment: AlignmentDirectional(0, -0.65),
              child: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: FaIcon(
                  FontAwesomeIcons.rulerVertical,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () async {
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor:
                        FlutterFlowTheme.of(context).primaryBackground,
                    context: context,
                    builder: (context) {
                      return Container(
                        height:
                            MediaQuery.of(context).copyWith().size.height * 0.2,
                        child: Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: StatefulBuilder(
                            builder: (BuildContext context, setState) {
                              var sliderval = _currentSliderValue.toInt();
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$sliderval' + ' ml',
                                    style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Slider(
                                    activeColor: Color(0xFF003366),
                                    value: _currentSliderValue,
                                    max: 1500,
                                    divisions: 150,
                                    label:
                                        _currentSliderValue.round().toString(),
                                    onChanged: (double value) {
                                      state() {}
                                      setState(() {
                                        _currentSliderValue = value;
                                      });
                                    },
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        FFAppState().cup =
                                            _currentSliderValue.toInt();
                                        Navigator.pop(context);
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: Color(0xFF003366),
                                        padding: const EdgeInsets.all(8.0),
                                        textStyle:
                                            const TextStyle(fontSize: 14),
                                      ),
                                      child: Text(
                                        'Save',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ))
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ).then((value) => setState(() {}));
                },
              ),
            ),
          ),
          Container(
            child: Align(
              alignment: AlignmentDirectional(0, -0.65),
              child: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: FaIcon(
                  FontAwesomeIcons.coffee,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  int? premium1 = prefs.getInt('premium');
                  if (premium1 == 1) {
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: DrinkselectWidget(),
                          ),
                        );
                      },
                    );
                  } else {
                    showDialog<String>(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          AlertDialog(
                                                            title: Row(
                                                              children: [
                                                                const Text(
                                                                    'Drink Type Selection '),
                                                               
                                                              ],
                                                            ),
                                                            content: const Text(
                                                                'Buy Premium to unlock this feature'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () =>
                                                                    showModalBottomSheet(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return premium();
                                                                        }),
                                                                child: Center(
                                                                  child: const Text(
                                                                      'Buy Premium Now',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          fontWeight:
                                                                              FontWeight.w500)),
                                                                ),
                                                              ),
                                                            ],
                                                          ));
                  }
                },
              ),
            ),
          ),
          Container(
            child: Align(
              alignment: AlignmentDirectional(0, -0.65),
              child: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: FaIcon(
                  FontAwesomeIcons.history,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );

                  adCounter++;
                  adActionsSet(adCounter);

                  if ((adCounter % 5 == 0) & adsonline) {
                    InterstitialAd.load(
                        adUnitId: 'ca-app-pub-5585667908104814/3919550824',
                        request: const AdRequest(),
                        adLoadCallback:
                            InterstitialAdLoadCallback(onAdLoaded: (ad) {
                          interstitialAdHist = ad;
                          interstitialAdHist!.show();

                          interstitialAdHist!.fullScreenContentCallback =
                              FullScreenContentCallback(
                            onAdFailedToShowFullScreenContent: (ad, error) {
                              debugPrint(error.message);
                              ad.dispose();
                              interstitialAdHist!.dispose();
                            },
                            onAdDismissedFullScreenContent: (ad) {
                              ad.dispose();
                              interstitialAdHist!.dispose();
                            },
                          );
                        }, onAdFailedToLoad: (err) {
                          debugPrint(err.message);
                        }));
                  }
                },
              ),
            ),
          ),
          Container(
            child: Align(
              alignment: AlignmentDirectional(0, -0.65),
              child: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsWidget(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}