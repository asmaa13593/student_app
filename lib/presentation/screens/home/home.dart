import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_app/business_logic/cubits/home/home_cubit.dart';
import 'package:student_app/presentation/screens/home/subject_item.dart';
import 'package:student_app/presentation/widgets/network_indicator.dart';
import 'package:student_app/presentation/widgets/page_container.dart';
import 'package:student_app/utils/app_colors.dart';
import 'package:student_app/utils/hex_color.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  final int? studentId;
  const HomeScreen({Key? key, this.studentId}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentDot = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context)
        .getStudentDashboard(studentId: '${widget.studentId}');
  }

  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: mainAppColor,
            elevation: 0,
            leading: GestureDetector(
                child: const Icon(
              Icons.menu,
              color: Colors.white,
            )),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
            ],
          ),
          body: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              return _buildBodyItem(state);
            },
          ),
        ),
      ),
    );
  }

  _buildBodyItem(state) {
    if (state is HomeLoadingState) {
      return Center(
        child: CircularProgressIndicator(color: mainAppColor),
      );
    } else if (state is StudentDashboardSuccess) {
      return Stack(alignment: Alignment.bottomCenter, children: [
        Image.asset(
          "assets/images/backhome.png",
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  color: mainAppColor,
                ),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 10, 10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: homeBackgroundCard,
                              radius: 45.r,
                              child: ClipOval(
                                child: Image.network(
                                  state.studentDashboard.studentInformation!
                                              .photo !=
                                          null
                                      ? state.studentDashboard
                                          .studentInformation!.photo
                                          .toString()
                                      : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRf59ssg3okpL3Y5jOaEZDuZsA5-cJgSzc56A&usqp=CAU",
                                  height: 80.h,
                                  width: 80.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Row(children: [
                                  Text(
                                    "Hi,",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15.sp),
                                  ),
                                  Text(
                                    state.studentDashboard.studentInformation!
                                        .name!,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15.sp),
                                  ),
                                ]),
                                const SizedBox(
                                  height: 3,
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "${state.studentDashboard.studentInformation!.className!}   ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 9.sp),
                                      ),
                                      Text(
                                        "  |  ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 9.sp),
                                      ),
                                      Text(
                                        "${state.studentDashboard.studentInformation!.levelName!}  ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 9.sp),
                                      ),
                                    ]),
                                const SizedBox(
                                  height: 3,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: homeBackgroundCard,
                                  ),
                                  child: Text(
                                    "${state.studentDashboard.studentInformation!.academicYearName}",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                    Stack(children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                        height: 270.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: HexColor("#00000029").withOpacity(0.5),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: HexColor("#FFF7D6"),
                                    radius: 40.r,
                                    child: Image.asset(
                                      "assets/images/flame_training.png",
                                      height: 65.h,
                                      width: 65.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    "Lectures",
                                    style: TextStyle(
                                        color: HexColor("#5C4DB1"),
                                        fontSize: 10.sp),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: HexColor("#EDFDFF"),
                                    radius: 40.r,
                                    child: Image.asset(
                                      "assets/images/calendar.png",
                                      height: 75.h,
                                      width: 75.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    "Missed Lectures",
                                    style: TextStyle(
                                        color: HexColor("#5C4DB1"),
                                        fontSize: 10.sp),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: HexColor("#FFF7D6"),
                                    radius: 40.r,
                                    child: Image.asset(
                                      "assets/images/schedule.png",
                                      height: 45.h,
                                      width: 45.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    "Daily Lecture",
                                    style: TextStyle(
                                        color: HexColor("#5C4DB1"),
                                        fontSize: 10.sp),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Stack(alignment: Alignment.bottomCenter, children: [
                            Container(
                                height: 170.h,
                                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: HexColor('#F8FAFC'),
                                    border:
                                        Border.all(color: HexColor("#CFE1FB"))),
                                child: ListView.builder(
                                  itemCount:
                                      state.studentDashboard.subjects!.length,
                                  itemBuilder: (context, index) {
                                    return SubjectsItem(
                                      subject: state
                                          .studentDashboard.subjects![index],
                                    );
                                  },
                                )),
                            Container(
                                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                height: 40.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: HexColor('#F8FAFC').withOpacity(.9),
                                ))
                          ]),
                        ],
                      ),
                    ]),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  _buildDailyLectureCarouselSlider(state),
                  _buildAssignmentCarouselSlider(state),
                  _buildExamsCarouselSlider(state),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ]);
    } else if (state is StudentDashboardFailure) {
      return Center(child: Text(state.message));
    }
  }

  _buildAssignmentCarouselSlider(StudentDashboardSuccess state) {
    final List<Widget> assignmentSliders = state.studentDashboard.assignments!
        .map((i) =>
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                children: [
                  Container(
                    height: 30.h,
                    width: 5.w,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(3),
                          bottomRight: Radius.circular(3)),
                      color: HexColor("#8B0000"),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        i.materialName.toString(),
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: HexColor("#0F0A39")),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        DateFormat('EEE dd/MM/yyyy')
                            .format(i.assignmentDueDate!),
                        style: TextStyle(
                            fontSize: 10.sp, color: HexColor("#0F0A39")),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 20,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: HexColor("#8B0000"),
                ),
                child: Text(
                  DateFormat('kk:mm a').format(i.assignmentDueDate!),
                  style: TextStyle(fontSize: 10.sp, color: Colors.white),
                ),
              ),
            ]))
        .toList();

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              color: HexColor("#FFF7D6"),
              border: Border.all(color: mainAppColor, width: .5)),
          height: 110.h,
          width: 100.w,
          child: Column(
            children: [
              CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                    height: 90.h,
                    autoPlay: true,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentDot = index;
                      });
                    }),
                items: assignmentSliders,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      state.studentDashboard.assignments!.asMap().entries.map(
                    (entry) {
                      return GestureDetector(
                        onTap: () =>
                            _carouselController.animateToPage(entry.key),
                        child: Container(
                          width: 7.0,
                          height: 7.0,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black)
                                  .withOpacity(
                                      _currentDot == entry.key ? 0.9 : 0.4)),
                        ),
                      );
                    },
                  ).toList()),
            ],
          ),
        ),
        Container(
            color: HexColor("#FFF7D6"),
            margin: const EdgeInsets.fromLTRB(10, 0, 40, 0),
            child: Text(
              "Assignment",
              style: TextStyle(fontSize: 10.sp),
            ))
      ],
    );
  }

  _buildDailyLectureCarouselSlider(StudentDashboardSuccess state) {
    final List<Widget> examstSliders = state.studentDashboard.dailyLectures!
        .map((i) =>
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.network(
                        "https://img2.arabpng.com/20180328/suq/kisspng-color-wheel-switch-computer-icons-color-5abbe67ac38b23.441536901522263674801.jpg"),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        i.isBreakTime! ? "Break" : i.subjectName.toString(),
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: HexColor("#01064E")),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                indent: 1,
                thickness: 2,
                height: 10.h,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    (i.fromTime!),
                    style:
                        TextStyle(fontSize: 10.sp, color: HexColor('#01064E')),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 20,
                    padding:
                        EdgeInsets.symmetric(horizontal: 9.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: HexColor("#8B0000"),
                    ),
                    child: Text(
                      ("JOIN"),
                      style: TextStyle(fontSize: 12.sp, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ]))
        .toList();

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              color: HexColor("#EFF7FF"),
              border: Border.all(color: mainAppColor, width: .5)),
          height: 110.h,
          width: 100.w,
          child: Column(
            children: [
              CarouselSlider(
                  options: CarouselOptions(
                    height: 90.0,
                    autoPlay: true,
                    viewportFraction: 1,
                  ),
                  items: examstSliders),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      state.studentDashboard.dailyLectures!.asMap().entries.map(
                    (entry) {
                      return GestureDetector(
                        onTap: () =>
                            _carouselController.animateToPage(entry.key),
                        child: Container(
                          width: 7.0,
                          height: 7.0,
                          margin: const EdgeInsets.symmetric(horizontal: 2.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black)
                                  .withOpacity(
                                      _currentDot == entry.key ? 0.9 : 0.4)),
                        ),
                      );
                    },
                  ).toList()),
            ],
          ),
        ),
        Container(
            color: HexColor("#EFF7FF"),
            margin: const EdgeInsets.fromLTRB(10, 0, 40, 0),
            child: Text(
              "DailyLecture",
              style: TextStyle(fontSize: 10.sp),
            ))
      ],
    );
  }

  _buildExamsCarouselSlider(StudentDashboardSuccess state) {
    final List<Widget> examstSliders = state.studentDashboard.exams!
        .map((i) =>
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                children: [
                  Container(
                    height: 30.h,
                    width: 5.w,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(3),
                          bottomRight: Radius.circular(3)),
                      color: HexColor("#00C3DE"),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        i.courseName.toString(),
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        DateFormat('EEE dd/MM/yyyy').format(i.createdDate!),
                        style: const TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 20,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: HexColor("#00C3DE"),
                ),
                child: Text(
                  DateFormat('kk:mm a').format(i.createdDate!),
                  style: TextStyle(fontSize: 10.sp, color: Colors.white),
                ),
              ),
            ]))
        .toList();

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              color: HexColor("#C7E1FB"),
              border: Border.all(color: mainAppColor, width: .5)),
          height: 110.h,
          width: 100.w,
          child: Column(
            children: [
              CarouselSlider(
                  options: CarouselOptions(
                    height: 90.0,
                    autoPlay: true,
                    viewportFraction: 1,
                  ),
                  items: examstSliders),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: state.studentDashboard.exams!.asMap().entries.map(
                    (entry) {
                      return GestureDetector(
                        onTap: () =>
                            _carouselController.animateToPage(entry.key),
                        child: Container(
                          width: 7.0,
                          height: 7.0,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black)
                                  .withOpacity(
                                      _currentDot == entry.key ? 0.9 : 0.4)),
                        ),
                      );
                    },
                  ).toList()),
            ],
          ),
        ),
        Container(
            color: HexColor("#C7E1FB"),
            margin: const EdgeInsets.fromLTRB(10, 0, 40, 0),
            child: Text(
              "Exams",
              style: TextStyle(fontSize: 10.sp),
            ))
      ],
    );
  }
}
