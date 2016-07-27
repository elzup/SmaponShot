import Foundation
import UIKit

class TouchPoint : Hashable {
    internal var touch: UITouch!
    internal var timestamp: Double

    var hashValue: Int {
        return Int(self.timestamp) + touch.hash
    }

    init(touch: UITouch) {
        self.touch = touch
        self.timestamp = CACurrentMediaTime()
    }

}

func ==(lhs: TouchPoint, rhs: TouchPoint) -> Bool {
    return lhs.hashValue == rhs.hashValue
}