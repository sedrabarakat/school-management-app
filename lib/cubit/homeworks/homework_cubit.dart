
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:meta/meta.dart';
import 'package:school_app/constants.dart';
import 'package:school_app/models/error_model.dart';
import 'package:school_app/models/homework/homework.dart';
import 'package:school_app/network/remote/dio_helper.dart';

part 'homework_state.dart';

class HomeworkCubit extends Cubit<HomeworkState> {
  HomeworkCubit() : super(HomeworkInitial());

  static HomeworkCubit get(context) => BlocProvider.of(context);

  ErrorModel? errorModel;

  HomeworkModel? homeworkModel;

  Future getHomeworks({required int student_id}) async {
    emit(GetHomeworkLoading());
    DioHelper.postData(
            url: 'getHomeworks',
            data: {
              'student_id': student_id,
            },
            token: token)
        .then((value) async {
      print('value.data: ${value.data}');
      homeworkModel = HomeworkModel.fromJson(value.data);

      emit(GetHomeworkSuccess());
    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      errorModel = ErrorModel.fromJson(error.response.data);
      emit(GetHomeworkError(errorModel!));
      print(error.toString());
    });
  }


  int progress = 0;

  Future downloadFile(String url) async {
    FileDownloader.downloadFile(
        url: url.trim(),
        onProgress: (name, progress) {
          progress = progress;
          emit(DownloadFileLoading());
        },
        onDownloadCompleted: (value) {
          print(value);
          progress = 0;
          emit(DownloadFileSuccess());
        },
        onDownloadError: (value) {
          print(value);
          emit(DownloadFileError());
        }
    );
  }


  /*


  Future openFile({required String url}) async {
    final name = url.split('/').last;
    final file = await downloadFile(url, name);
    if (file == null) return;

    emit(DownloadFileSuccess());

    print('Path: ${file.path}');

    //OpenFile.open(file.path);
  }

  Future<File?> downloadFile(String url, String name) async {
    try {
      final appStorage = await getTemporaryDirectory();
      final file = File('${appStorage.path}/$name');

      print('${appStorage.path}/$name');

      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ),
      );

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      return file;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> startDownload(fileUrl) async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      final name = fileUrl.split('/').last;
      print(name);
      final appDocDir = await getExternalStorageDirectory();
      final downloadFolder = appDocDir!.path;
      final taskId = await FlutterDownloader.enqueue(
        url: fileUrl,
        savedDir: downloadFolder,
        fileName: name,
        showNotification: true,
        openFileFromNotification: true,
      );
    } else {
      print('no permission');
    }
  }

  */
}
