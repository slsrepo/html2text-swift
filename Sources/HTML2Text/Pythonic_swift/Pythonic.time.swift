// Python docs: https://docs.python.org/2/library/time.html
//
// Most frequently used:
//  513 time.time
//  304 time.sleep
//   19 time.asctime
//   16 time.strftime
//   15 time.mktime
//    8 time.localtime
//    8 time.gmtime
//    5 time.strptime
//    4 time.clock
//    3 time.ctime
//
// >>> filter(lambda s: not s.startswith("_"), dir(time))
//   accept2dyear
//   altzone
//   asctime
//   clock
//   ctime
//   daylight
//   gmtime
//   localtime
//   mktime
//   sleep
//   strftime
//   strptime
//   struct_time
//   time
//   timezone
//   tzname
//   tzset

import Foundation

public class time {
    public class func time() -> Double {
        let now = Date()
        return now.timeIntervalSince1970
    }

    public class func sleep(_ seconds: Double) {
        Thread.sleep(forTimeInterval: seconds)
    }
}
