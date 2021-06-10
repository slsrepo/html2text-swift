// Python docs: https://docs.python.org/2/library/json.html
//
// Most frequently used:
//  208 json.dumps
//  191 json.loads
//   28 json.load
//    9 json.dump
//    8 json.JSONEncoder
//    3 json.JSONDecoder
//
// >>> filter(lambda s: not s.startswith("_"), dir(json))
//   JSONDecoder
//   JSONEncoder
//   decoder
//   dump
//   dumps
//   encoder
//   load
//   loads
//   scanner

import Foundation

public class json {
    public class func dumps(obj: Any) -> String {
        let jsonData = try? JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
        if let jsonData = jsonData {
            return String(data: jsonData, encoding: .utf8)!
        }
        return ""
    }

    public class func loads(json: String) -> Any? {
        let jsonData = json.data(using: .utf8)
        let jsonObject = try? JSONSerialization.jsonObject(with: jsonData!, options: .mutableContainers)
        return jsonObject
    }
}
