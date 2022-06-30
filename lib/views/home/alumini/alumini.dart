import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'design/alumini_design.dart';
import 'model/user_alumini.dart';

class AluminiSCreen extends StatefulWidget {
  const AluminiSCreen({Key? key}) : super(key: key);

  @override
  State<AluminiSCreen> createState() => _AluminiSCreenState();
}

class _AluminiSCreenState extends State<AluminiSCreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Alumini ",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(),
          ),
          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection("alumini").snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                      child: Column(
                        children: const [
                          SizedBox(
                            height: 40.0,
                          ),
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      ),
                    )
                  : SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 1,
                      staggeredTileBuilder: (e) => const StaggeredTile.fit(1),
                      itemBuilder: (context, index) {
                        Alumini alumini = Alumini.fromJson(
                            snapshot.data!.docs[index].data()!
                                as Map<String, dynamic>);
                        return AluminiDesign(
                          model: alumini,
                          context: context,
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                    );
            },
          ),
        ],
      ),
    );
  }
}
