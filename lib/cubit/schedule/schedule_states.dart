abstract class Schedule_states{}

class init_schedule_state extends Schedule_states{}

class Loading_get_student_sch extends Schedule_states{}

class Success_get_student_sch extends Schedule_states{}

class Error_get_student_sch extends Schedule_states{
  String error;
  Error_get_student_sch(this.error);
}

class Loading_get_teacher_sch extends Schedule_states{}

class Success_get_teacher_sch extends Schedule_states{}

class Error_get_teacher_sch extends Schedule_states{
  String error;
  Error_get_teacher_sch(this.error);
}

class Loading_get_Exam_pic extends Schedule_states{}

class Success_get_Exam_pic extends Schedule_states{}

class Error_get_Exam_pic extends Schedule_states{
  String error;
  Error_get_Exam_pic(this.error);
}