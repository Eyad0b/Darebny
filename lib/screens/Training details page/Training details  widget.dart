import 'package:flutter/material.dart';

import '../../Models/models.dart';

class CoverDetailsp extends StatefulWidget {
  CoverDetailsp({
    required this.backgroundImageUrl,
    super.key,
  });

  String backgroundImageUrl;

  @override
  State<CoverDetailsp> createState() => _CoverDetailspState();
}

class _CoverDetailspState extends State<CoverDetailsp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  widget.backgroundImageUrl),
              fit: BoxFit.cover)),
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      child: const Padding(
        padding: EdgeInsets.only(top: 30, right: 15),
        child: Icon(
          Icons.share_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}

class OfferTitle extends StatelessWidget {
  const OfferTitle({ required this.title,
    super.key,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class Date extends StatefulWidget {
  Date({
    required this.date,

    super.key,
  });
  String date;


  @override
  State<Date> createState() => _DateState();
}

class _DateState extends State<Date> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: DateTimelisttile(
        myicon: Icons.calendar_month_outlined,
        Date: widget.date,
        subdate: 'Tuesday 4:00pm- 9:00pm',
      ),
    );
  }
}

class Locationinfo extends StatelessWidget {
  const Locationinfo({
    required this.address,
    super.key,
  });
  final String address;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0, left: 6),
      child: DateTimelisttile(
        myicon: Icons.location_on,
        Date: address,
        subdate: '36 Guid Street London, UK',
      ),
    );
  }
}

class Jobdes extends StatelessWidget {
  const Jobdes({
    required this.description,
    super.key,
  });
  final String description;


  @override
  Widget build(BuildContext context) {
    return JobDescribation(
      Jobdescribation: description,
    );
  }
}

class Requirements extends StatelessWidget {
  const Requirements({
    required this.requirements,
    super.key,
  });
  final String requirements;

  @override
  Widget build(BuildContext context) {
    return RequirementsM(
      requirements:
          requirements,
    );
  }
}

class ApplyButton extends StatefulWidget {
  const ApplyButton({super.key});

  @override
  State<ApplyButton> createState() => _ApplyButtonState();
}

class _ApplyButtonState extends State<ApplyButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(30),
        child: SizedBox(
            height: 56,
            width: MediaQuery.of(context).size.width / 1.3,
            child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(205, 67, 58, 1))),
                onPressed: () {},
                child: const Text(
                  "Apply",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ))));
  }
}
