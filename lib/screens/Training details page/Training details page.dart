import 'package:darebny/screens/Training%20details%20page/Training%20details%20%20widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TrainingDetails extends StatefulWidget {
  TrainingDetails({
    required this.title,
    required this.date,
    required this.description,
    required this.requirements,
    required this.address,
    required this.supTitle,
    required this.backgroundImageUrl,
    super.key,
  });

  String requirements;
  String description;
  String title;
  String date;
  String address;
  String supTitle;
  String backgroundImageUrl;

  @override
  State<TrainingDetails> createState() => _TrainingDetailsState();
}

class _TrainingDetailsState extends State<TrainingDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          '${widget.supTitle} Opportunity details',
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.white.withOpacity(.5),
              ),
              height: MediaQuery.of(context).size.height * 0.09,
              width: MediaQuery.of(context).size.width * 0.09,
              child: const Icon(
                Icons.bookmark_outlined,
                color: Colors.white,
              ),
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        leading: const BackButton(),
        elevation: 0,
      ),
      body: Container(
        color: const Color.fromRGBO(218, 218, 218, 0.39),
        child: Column(
          children: [
            CoverDetailsp(backgroundImageUrl: widget.backgroundImageUrl),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  OfferTitle(title: widget.title),
                  Date(date: widget.date),
                  Locationinfo(address: widget.address),
                  Jobdes(description: widget.description),
                  Requirements(requirements: widget.requirements),
                  const ApplyButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
