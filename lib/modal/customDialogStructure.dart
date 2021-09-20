class CustomDialogStructure {
  String alertUrl = "";
  String alertImageUrl = "";
  String alertPosition = "";
  String startDate = "";
  String endDate = "";
  String buttonText = "";
  String enableCancelString = "";
  String bulletSymbol = "";
  String name = "";
  String businessId = "";
  String queueName = "";
  String status = "";
  String title = "";
  String headerText = "";
  String centerBulletText = "";
  String footerText = "";
  String emailAllowedString = "";
  String linkAllowedString = "";
  String phoneAllowedString = "";
  String email = "";
  String link = "";
  String phoneNumber = "";
  String bgColor = "";
  String titleColor = "";
  String msgColor = "";
  String titleFontString = "";
  String msgFontString = "";

  CustomDialogStructure(
      {this.alertUrl = "",
      this.alertImageUrl = "",
      this.alertPosition = "",
      this.startDate = "",
      this.endDate = "",
      this.buttonText = "",
      this.enableCancelString = "",
      this.bulletSymbol = "",
      this.name = "",
      this.businessId = "",
      this.queueName = "",
      this.status = "",
      this.title = "",
      this.headerText = "",
      this.centerBulletText = "",
      this.footerText = "",
      this.emailAllowedString = "",
      this.linkAllowedString = "",
      this.phoneAllowedString = "",
      this.email = "",
      this.link = "",
      this.phoneNumber = "",
      this.bgColor = "",
      this.titleColor = "",
      this.msgColor = "",
      this.titleFontString = "",
      this.msgFontString = ""});

  void fromJson(Map<String, dynamic> json) {
    alertUrl = json['alertUrl']==null?"":json['alertUrl'].toString();
    alertImageUrl = json['alertImageUrl']==null?"":json['alertImageUrl'].toString();
    alertPosition = json['alertPosition']==null?"":json['alertPosition'].toString();
    startDate = json['startDate']==null?"":json['startDate'].toString();
    endDate = json['endDate']==null?"":json['endDate'].toString();
    buttonText = json['buttonText']==null?"":json['buttonText'].toString();
    enableCancelString = json['enableCancelString']==null?"":json['enableCancelString'].toString();
    bulletSymbol = json['bulletSymbol']==null?"":json['bulletSymbol'].toString();
    name = json['name']==null?"":json['name'].toString();
    businessId = json['businessId']==null?"":json['businessId'].toString();
    queueName = json['queueName']==null?"":json['queueName'].toString();
    status = json['status']==null?"":json['status'].toString();
    title = json['title']==null?"":json['title'].toString();
    headerText = json['headerText']==null?"":json['headerText'].toString();
    centerBulletText = json['centerBulletText']==null?"":json['centerBulletText'].toString();
    footerText = json['footerText']==null?"":json['footerText'].toString();
    emailAllowedString = json['emailAllowedString']==null?"":json['emailAllowedString'].toString();
    linkAllowedString = json['smsAllowedString']==null?"":json['smsAllowedString'].toString();
    phoneAllowedString = json['phoneAllowedString']==null?"":json['phoneAllowedString'].toString();
    email = json['email']==null?"":json['email'].toString();
    link = json['smsNumber']==null?"":json['smsNumber'].toString();
    phoneNumber = json['phoneNumber']==null?"":json['phoneNumber'].toString();
    bgColor = json['bgColor']==null?"":json['bgColor'].toString();
    titleColor = json['titleColor']==null?"":json['titleColor'].toString();
    msgColor = json['msgColor']==null?"":json['msgColor'].toString();
    titleFontString = json['titleFontString']==null?"":json['titleFontString'].toString();
    msgFontString = json['msgFontString']==null?"":json['msgFontString'].toString();
  }
}
