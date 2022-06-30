import 'package:cached_network_image/cached_network_image.dart';
import 'package:college_app/views/home/alumini/model/user_alumini.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AluminiDesign extends StatefulWidget {
  Alumini? model;
  BuildContext? context;
  AluminiDesign({Key? key, this.model, this.context}) : super(key: key);

  @override
  _AluminiDesignState createState() => _AluminiDesignState();
}

class _AluminiDesignState extends State<AluminiDesign> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        height: 320,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const Divider(
              height: 4.0,
              thickness: 2.0,
              color: Colors.black,
            ),
            const SizedBox(
              height: 10.0,
            ),

            CachedNetworkImage(
              height: 220,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              imageUrl: widget.model!.imgUrl!,
              errorWidget: (context, url, error) => const Icon(Icons.error),
              placeholder: (context, url) => SizedBox(
                child: Column(
                  children: const [
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: CircularProgressIndicator(
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Image.network(
            //   widget.model!.imgUrl!,
            //   height: 220,
            //   width: MediaQuery.of(context).size.width,
            //   fit: BoxFit.cover,
            // ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              widget.model!.name! +
                  " : " +
                  widget.model!.soe! +
                  " - " +
                  widget.model!.eoe!,
              style: const TextStyle(
                fontFamily: "Signatra",
                fontSize: 18.0,
                color: Colors.blueAccent,
              ),
            ),
            Text(
              widget.model!.title!,
              style: const TextStyle(
                fontFamily: "Signatra",
                fontSize: 18.0,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              widget.model!.desc!,
              style: const TextStyle(
                fontFamily: "Signatra",
                fontSize: 18.0,
                color: Colors.blueAccent,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
