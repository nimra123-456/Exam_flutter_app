import 'package:get/get.dart';
import 'package:exam_app/models/student_attempt_paper_model.dart';
import 'package:exam_app/repository/repository_class.dart';

class ExamPaperController extends GetxController {
  var switchScreen = 0.obs;
  late StudentAttempPaperModel ExamList ;
  String ans = "";
  // For true False Screen
  var tf_correct = 0.obs;
  var tf_incorrect = 0.obs;
  var TF_paperTimeOver = false;

  void correctQs() => tf_correct++;
  void switchExamScreen() => switchScreen++;

  void incorrectQs() => tf_incorrect++;

  void timeOver() => TF_paperTimeOver = true;

  // For MCQS SCreen
  var mcqs_correct = 0.obs;
  var mcqs_incorrect = 0.obs;
  var mcqs_paperTimeOver = false;

  void mcqs_correctQs() => mcqs_correct++;

  void mcqs_incorrectQs() => mcqs_incorrect++;

  void mcqstimeOver() => mcqs_paperTimeOver = true;
  // Theory part data
  var Theory_paperTimeOver = false;
  void theoryPapertimeOver() => Theory_paperTimeOver = true;
  List studentAllAnswers = [];
  void savePaper() {
    getanswer();
    print("mcq $mcqs_correct");
    print("true false $tf_correct");
    print("theory $ans");
    print("paper auto Saved");
    // upload data to server
    Repository.saveStudentPaper(mcqs_correct.toString(), tf_correct.toString(),
        ans.toString(), ExamList.id.toString());
  }

// concatenating all answers
  void studentAutoCOmpleteSave() {
    if (TF_paperTimeOver && mcqs_paperTimeOver && Theory_paperTimeOver) {
      savePaper();
    }
  }

  getanswer() {
    for (int i = 0; i < studentAllAnswers.length; i++) {
      ans += studentAllAnswers[i];
    }
  }
}
