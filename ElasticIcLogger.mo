import Array "mo:base/Array";
import TextLoggers "TextLoggers";

actor Map {

  let n = 100; // number of buckets

  type TextLogger = TextLoggers.TextLogger;

  let text_loggers : [var ?TextLogger] = Array.init(n, null);

  public func view(from : Nat, to : Nat) : async () {
    switch (text_loggers[to % n]) {
      case null null;
      case (?text_logger) await text_logger.view(from, to);
    };
  };

  public func append(e : Nat, v : [Text]) : async () {
    let i = e % n;
    let text_logger = switch (text_loggers[i]) {
      case null {
        let l = await TextLoggers.TextLogger(); 
        text_loggers[i] := ?l;
        l;
      };
      case (?text_logger) text_logger;
    };
    await text_logger.append(e, v);
  };

};