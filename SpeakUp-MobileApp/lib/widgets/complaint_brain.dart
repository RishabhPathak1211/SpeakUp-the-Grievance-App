class ComplaintBrain {
  String subject;
  String complaint;

  ComplaintBrain(this.subject, this.complaint);

  Map toJson() => {
        'subject': subject,
        'complaint': complaint,
      };
}
