enum FollowupStatus {
  yes, 
  no; 

  bool get isFollowup => this == FollowupStatus.yes;
}
