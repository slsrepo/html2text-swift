import Foundation

public class uuid {
    public class func uuid4() -> NSUUID {
        return NSUUID()
    }
}

public extension NSUUID {
    var hex: String {
        return self.uuidString.lower().replace("-", "")
    }
}
