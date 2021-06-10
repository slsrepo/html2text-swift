import Foundation

public class shutil {
    public class func copyFile(_ src: String, _ dst: String) {
        do {
            try FileManager().copyItem(atPath: src, toPath: dst)
        } catch let error {
            print(error)
        }
    }

    public class func copyfile(_ src: String, _ dst: String) {
        return copyFile(src, dst)
    }
}
