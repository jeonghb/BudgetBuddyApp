class Position {
  int positionId = -1;
  String positionName = '';
  int authFlag = 0;
  bool activationStatus = true;

  void setData(var json) {
    positionId = int.parse(json['positionId'].toString());
    positionName = json['positionName'];
    // authFlag = int.parse(json['authFlag'].toString());
    activationStatus = json['positionActivationStatus'] == 1 ? true : false;
  }
}