import 'package:flutter/material.dart';
import 'package:share_extend/share_extend.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:intent/intent.dart' as android_intent;
import 'package:intent/action.dart' as android_action;

class ContactUsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _launchURL() async {
      android_intent.Intent()
        ..setAction(android_action.Action.ACTION_DIAL)
        ..setData(Uri(scheme: "tel", path: "+91-120-426-9272"))
        ..startActivity().catchError((e) => print(e));
    }

    _sharedetail() {
      ShareExtend.share(
          "Successive Technologies, Noida, Uttar Pradesh  Web: https://successive.tech/  Phone number: +91-120-426-9272",
          "text",
          sharePanelTitle: "Contact Details",
          subject: "Contact Details",
          extraText: "+91-120-426-9272");
    }

    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Successive Technologies',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Noida, Uttar Pradesh ',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    InkWell buildButtonColumn(
        Color color, IconData icon, String label, Function onTab) {
      return InkWell(
        splashColor: Colors.blue[100],
        onTap: onTab,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButtonColumn(color, Icons.call, 'CALL', () {
            _launchURL();
          }),
          buildButtonColumn(color, Icons.near_me, 'MAP', () async {
            final availableMaps = await MapLauncher.installedMaps;

            await availableMaps.first.showMarker(
              coords: Coords(28.5994907, 77.3315516),
              title: "Successive Technologies",
              description:
                  "Address: E-29, E Block, Buddh Vihar, Noida, Uttar Pradesh 201301",
            );
          }),
          buildButtonColumn(color, Icons.share, 'SHARE', () {
            _sharedetail();
          }),
        ],
      ),
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        'Successive Software is a global consulting and IT services company'
        'with a specialized focus in ERP/SaaS solutions,Google Maps applications,'
        'GPS/GIS applications, custom software development, e-commerce solutions'
        'and mobile application development. Successive delivers targeted'
        'Transform and reinvent businesses one step at a'
        'time. As a leading technology services provider, we offer solutions to'
        'various industry segments such as e-commerce, legal tech, fintech, media'
        'agri-tech, telecom, logistics and more. Our 500+ employees are highly skilled'
        'at leveraging intelligent processes, in-depth analytics and innovative '
        'technology to achieve the best possible results.',
        softWrap: true,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'images/reception.jpg',
                width: 600,
                height: 240,
                fit: BoxFit.cover,
              ),
              titleSection,
              buttonSection,
              textSection,
            ],
          ),
        ),
      ),
    );
  }
}
