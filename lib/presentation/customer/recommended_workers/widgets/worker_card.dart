import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laborlink/core/app_export.dart';
import 'package:laborlink/models/wrokers_model.dart';

class WorkerCard extends StatefulWidget {
  final WorkersModel worker;
  const WorkerCard({super.key, required this.worker});

  @override
  State<WorkerCard> createState() => _WorkerCardState();
}

class _WorkerCardState extends State<WorkerCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: darkPurple,
      margin: EdgeInsets.symmetric(
          horizontal: Get.width * 0.04, vertical: Get.height * 0.01 / 2),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Get.width * 0.03)),
      elevation: 0.5,
      child: InkWell(
        child: ListTile(
          // leading: CircleAvatar(child: Icon(Icons.person),),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(Get.height*0.3),
            child: CachedNetworkImage(
              width: Get.height* 0.055,
              height: Get.height* 0.055,
              imageUrl: widget.worker.profilePhoto,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context,url,error)=>CircleAvatar(child: Icon(Icons.person),),
            ),
          ),
          title: Text(widget.worker.displayName, style: TextStyle(color: Colors.white)),
          subtitle: Text(
            widget.worker.email,
            maxLines: 1,
            style: TextStyle(
              color: appTheme.whiteA70002,
              fontSize: Get.height*0.008,
            ),
          ),
          trailing: TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Colors.white),
              backgroundColor: MaterialStatePropertyAll(Colors.transparent),
            ),
            child: Text('Book'),
            onPressed: (){
              Get.toNamed(AppRoutes.scheduling, arguments: [widget.worker.displayName,widget.worker.email,widget.worker.profilePhoto]);
            },
          ),
          // trailing: Text('12:00 PM', style: TextStyle(color: Colors.black26)),
        ),
      ),
    );
  }
}

