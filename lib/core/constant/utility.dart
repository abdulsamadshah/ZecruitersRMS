class Utility {
  static bool isNullEmptyOrFalse(Object? o) {
    return o == null ||
        o == "0.0" ||
        o == "0" ||
        o == 0 ||
        false == o ||
        "" == o ||
        "null" == o ||
        "false" == o;
  }

  static bool isNotNullEmptyOrFalse(Object? o) {
    return !isNullEmptyOrFalse(o);
  }
   static bool isNewNullEmptyOrFalse(Object? o) {
    return o == null ||
        false == o ||
        "" == o ||
        "null" == o ||
        "false" == o;
  }
}
