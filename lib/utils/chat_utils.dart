String getChatId(String uid1, String uid2) {
  return uid1.hashCode <= uid2.hashCode
      ? '$uid1\_$uid2'
      : '$uid2\_$uid1';
}
