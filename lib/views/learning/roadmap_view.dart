import 'package:communityapp/models/course_model.dart';

import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyRoadMapScreen extends StatelessWidget {
  final CourseModel myCourse;
  MyRoadMapScreen({super.key, required this.myCourse});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: courseAppBar(myCourse.title),
        body: OrientationBuilder(
          builder: (context, orientation) {
            return Container(
                color: Colors.white,
                child: Expanded(
                  child: ListView.builder(
                      itemCount: myCourse.milestones.length,
                      itemBuilder: (context, index) {
                        MilestoneModel currMileStone =
                            myCourse.milestones[index];
                        if (index == 0) {
                          return Column(
                            children: [
                              TimelineTile(
                                alignment: TimelineAlign.manual,
                                lineXY: 0.1,
                                isFirst: true,
                                endChild: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, bottom: 15, top: 30, right: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        currMileStone.topic,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        currMileStone.info!,
                                        textAlign: TextAlign.start,
                                      )
                                    ],
                                  ),
                                ),
                                indicatorStyle: IndicatorStyle(
                                    width: 25,
                                    color: Color(0xff00FF9D),
                                    indicator: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff00FF9D)),
                                      child:
                                          Center(child: Text('${index + 1}')),
                                    )),
                                beforeLineStyle: const LineStyle(
                                  color: Color(0xff94E7C7),
                                  thickness: 3,
                                ),
                              ),
                              myDivider(),
                            ],
                          );
                        } else if (index == myCourse.milestones.length - 1) {
                          if (index % 2 == 0) {
                            return Column(
                              children: [
                                TimelineTile(
                                  alignment: TimelineAlign.manual,
                                  lineXY: 0.1,
                                  isLast: true,
                                  beforeLineStyle: const LineStyle(
                                    color: Color(0xff94E7C7),
                                    thickness: 3,
                                  ),
                                  endChild: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30,
                                        bottom: 35,
                                        top: 35,
                                        right: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          currMileStone.topic,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          currMileStone.info!,
                                          textAlign: TextAlign.start,
                                        )
                                      ],
                                    ),
                                  ),
                                  indicatorStyle: IndicatorStyle(
                                    width: 25,
                                    color: Color(0xff00FF9D),
                                    indicator: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff00FF9D)),
                                      child:
                                          Center(child: Text('${index + 1}')),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Column(
                              children: [
                                TimelineTile(
                                  alignment: TimelineAlign.manual,
                                  lineXY: 0.9,
                                  isLast: true,
                                  beforeLineStyle: const LineStyle(
                                    color: Color(0xff94E7C7),
                                    thickness: 3,
                                  ),
                                  startChild: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30,
                                        bottom: 35,
                                        top: 35,
                                        right: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          currMileStone.topic,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          currMileStone.info!,
                                          textAlign: TextAlign.start,
                                        )
                                      ],
                                    ),
                                  ),
                                  indicatorStyle: IndicatorStyle(
                                    width: 25,
                                    color: Color(0xff00FF9D),
                                    indicator: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff00FF9D)),
                                      child:
                                          Center(child: Text('${index + 1}')),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        } else {
                          return middleTile(index, currMileStone);
                        }
                      }),
                ));
          },
        ));
  }

  PreferredSizeWidget courseAppBar(String name) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      title: Text(name),
    );
  }

  Widget myDivider() {
    return TimelineDivider(
      thickness: 3,
      begin: .1,
      end: .9,
      color: Color(0xff94E7C7),
    );
  }

  Widget middleTile(int index, MilestoneModel currMileStone) {
    if (index % 2 == 0) {
      return Column(
        children: [
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0.1,
            isLast: false,
            beforeLineStyle: const LineStyle(
              color: Color(0xff94E7C7),
              thickness: 3,
            ),
            endChild: Padding(
              padding: const EdgeInsets.only(
                  left: 30, bottom: 35, top: 35, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currMileStone.topic,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    currMileStone.info!,
                    textAlign: TextAlign.start,
                  )
                ],
              ),
            ),
            indicatorStyle: IndicatorStyle(
              width: 25,
              color: Color(0xff00FF9D),
              indicator: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xff00FF9D)),
                child: Center(child: Text('${index + 1}')),
              ),
            ),
          ),
          myDivider(),
        ],
      );
    } else {
      return Column(
        children: [
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0.9,
            beforeLineStyle: const LineStyle(
              color: Color(0xff94E7C7),
              thickness: 3,
            ),
            afterLineStyle: const LineStyle(
              color: Color(0xff94E7C7),
              thickness: 3,
            ),
            startChild: Padding(
              padding: const EdgeInsets.only(
                  left: 25, right: 20, top: 35, bottom: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currMileStone.topic,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    currMileStone.info!,
                    textAlign: TextAlign.start,
                  )
                ],
              ),
            ),
            indicatorStyle: IndicatorStyle(
              width: 25,
              color: Color(0xff00FF9D),
              indicator: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xff00FF9D)),
                child: Center(child: Text('${index + 1}')),
              ),
            ),
          ),
          myDivider(),
        ],
      );
    }
  }
}
