import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sim_jalan_mobile/common/common.dart';

export 'api_helper.dart';
export 'extensions.dart';
export 'logger.dart';

TextTheme textTheme(context) => Theme.of(context).textTheme;

const Widget verticalSpaceTiny = SizedBox(height: 5.0);

const Widget verticalSpaceSmall = SizedBox(height: 10.0);

const Widget verticalSpaceRegular = SizedBox(height: 18.0);

const Widget verticalSpaceMedium = SizedBox(height: 25);

const Widget verticalSpaceLarge = SizedBox(height: 50.0);

const Widget verticalSpaceMassive = SizedBox(height: 120.0);

Widget loadData(LoadStatus? load,
    {required String? msg, required Widget child, Widget? loading, Widget? error, Function? onError}) {
  switch (load!) {
    case LoadStatus.initial:
    case LoadStatus.loading:
      // return loading ??
      //     Center(
      //       child: Lottie.asset('assets/lottie/loading.json', height: 120, width: 120),
      //     );
      return loading ??
          const Center(
            child: CircularProgressIndicator(),
          );
    case LoadStatus.error:
      return error ??
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('$msg'),
                if (onError != null) const SizedBox(height: 8),
                if (onError != null)
                  ElevatedButton.icon(
                    onPressed: () {
                      onError();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Refresh'),
                  ),
              ],
            ),
          );
    case LoadStatus.success:
      return child;
  }
}

showLoadDialog(
  LoadStatus? load,
  loadingMsg, [
  errorMsg,
  successMsg,
]) {
  if (load == LoadStatus.loading) {
    EasyLoading.show(status: loadingMsg ?? 'Loading', dismissOnTap: false);
  }
  if (load == LoadStatus.error) {
    EasyLoading.showError(errorMsg ?? 'Error', duration: const Duration(seconds: 4));
  }
  if (load == LoadStatus.success) {
    EasyLoading.showSuccess(successMsg ?? "Success");
  }
}
