DateTime getDate(){
  final int timestamp = DateTime
      .now()
      .millisecondsSinceEpoch;
  return DateTime.fromMillisecondsSinceEpoch(timestamp);
}