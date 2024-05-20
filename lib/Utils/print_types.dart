// ignore_for_file: constant_identifier_names

class PrintTypes {
  static String info =
          "                        ${Logger.Red.message("INFO")}                          ",
      error =
          "                       ${Logger.Red.message("ERROR")}                          ",
      warning =
          "                      ${Logger.Red.message("WARNING")}                         ",
      success =
          "                      ${Logger.Red.message("SUCCESS")}                         ",
      debug =
          "                       ${Logger.Red.message("DEBUG")}                          ",
      verbose =
          "                      ${Logger.Red.message("VERBOSE")}                         ",
      wtf =
          "                        ${Logger.Red.message("WTF")}                          ";
}

enum Logger {
  Black("30"),
  Red("31"),
  Green("32"),
  Yellow("33"),
  Blue("34"),
  Magenta("35"),
  Cyan("36"),
  White("37");

  final String code;
  const Logger(this.code);

  dynamic message(dynamic text) => text;
  // ("\x1B[" + code + 'm' + text.toString() + '\x1B[0m');
}
