import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zecruiters_rms/core/common_widget/appBar.dart';
import 'package:zecruiters_rms/data/models/CandiDateListRes.dart';
import 'package:zecruiters_rms/logic/bloc/CandiDate/candi_date_cubit.dart';
import 'package:zecruiters_rms/presentation/common_widget/common_widget.dart';
import 'package:zecruiters_rms/presentation/screen/Detail/Candidate/CandidateDetail.dart';

class CandidateListScreen extends StatefulWidget {
  String jdId;
  int listType;
  CandidateListScreen({super.key, required this.jdId, required this.listType});

  @override
  State<CandidateListScreen> createState() => _CandidatedetailScreenState();
}

class _CandidatedetailScreenState extends State<CandidateListScreen> {
  final CandiDateCubit candiDateCubit = CandiDateCubit();

  @override
  void initState() {
    super.initState();
    candiDateCubit.getCandidateData(
        jdId: widget.jdId, listType: widget.listType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context, title: "Candidate Lists", type: "basic"),
      body: Padding(
          padding: EdgeInsets.all(8.0.r),
          child: BlocConsumer<CandiDateCubit, CandiDateState>(
            bloc: candiDateCubit,
            listener: (context, state) {},
            builder: (context, state) {
              switch (state.runtimeType) {
                case LoadingState:
                  return CandiDateListUi(context, isLoading: true);

                case LoadingError:
                  final networkconnectionlost = state as LoadingError;
                  return LostinternetConnection(
                      retry: () {
                        candiDateCubit.getCandidateData(
                            jdId: widget.jdId, listType: widget.listType);
                      },
                      messgae: networkconnectionlost.error.toString());

                case CandiDateLoadingSuccess:
                  final list = state as CandiDateLoadingSuccess;
                  if (list.listData!.isEmpty) {
                    return Align(
                        alignment: Alignment.center,
                        child: reausabletext("No Data Found"));
                  } else {
                    return CandiDateListUi(context, data: list.listData);
                  }

                default:
                  return const SizedBox();
              }
            },
          )),
    );
  }

  Widget CandiDateListUi(
    BuildContext context, {
    List<CandiDateData>? data,
    bool isLoading = false,
  }) {
    return Skeletonizer(
      enabled: isLoading,
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: data?.length,
        itemBuilder: (ctx, index) {
          final user = data?[index];

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CandidateDetailScreen(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
              child: Card(
                elevation: 6,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 28.r,
                            backgroundColor: Colors.grey[300],
                            child: Icon(
                              Icons.person,
                              size: 28.r,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              reausabletext(
                                widths: 240,
                                textoverflow: TextOverflow.ellipsis,
                                'Name: ${user?.firstName ?? "N/A"} ${user?.lastName ?? ""}',
                                fontsize: 16,
                                fontweight: FontWeight.bold,
                              ),
                              SizedBox(height: 4.h),
                              reausabletext(
                                widths: 240,
                                maxline: 2,
                                'Email: ${user?.emailId ?? "N/A"}',
                                fontsize: 14,
                                color: Colors.grey[700],
                              ),
                              SizedBox(height: 4.h),
                              reausabletext(
                                'Mobile: ${user?.contactNo ?? "N/A"}',
                                fontsize: 14,
                                color: Colors.grey[700],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildIconButton(
                            icon: Icons.call,
                            color: Colors.green,
                            onTap: () async {
                              String url = "tel:${user?.contactNo ?? ""}";
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not make the phone call.';
                              }
                            },
                          ),
                          _buildIconButton(
                            icon: Icons.email,
                            color: Colors.blue,
                            onTap: () async {
                              String url = "mailto:${user?.emailId ?? ""}";
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not send the email.';
                              }
                            },
                          ),
                          _buildIconButton(
                            icon: FontAwesomeIcons.whatsapp,
                            color: Colors.teal,
                            onTap: () async {
                              String url =
                                  "https://wa.me/${user?.contactNo ?? ""}";
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not open WhatsApp.';
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Helper Method for Icon Button with Background
  Widget _buildIconButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1), // Light background with the same color
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 28.r,
          color: color,
        ),
      ),
    );
  }
}
