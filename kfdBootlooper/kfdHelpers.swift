import Foundation
import UIKit
import URLBackport
import SwiftKFD_objc

public func overwriteFile(at url: URL, with data: Data) throws {
    let cPathTo = url.path.withCString { ptr in
        return strdup(ptr)
    }
    let tmpURL = URL.backport.temporaryDirectory.appendingPathComponent("tmp", conformingTo: .directory)
    
    try data.write(to: tmpURL)
    
    let cPathFrom = tmpURL.path.withCString { ptr in
        return strdup(ptr)
    }

    funVnodeOverwrite2(cPathTo!, cPathFrom)

    try FileManager.default.removeItem(at: tmpURL)
}

public func exitApp() {
    UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
        exit(0)
    }
}
