import Foundation
import UIKit

class TouchPoint : Hashable {
    internal var touch: UITouch!
    internal var point: CGPoint!
    internal var timestamp: Double

    var hashValue: Int {
        return Int(self.timestamp) + touch.hash
    }

    init(touch: UITouch, point: CGPoint) {
        self.touch = touch
        self.point = point
        self.timestamp = CACurrentMediaTime()
    }

}

func ==(lhs: TouchPoint, rhs: TouchPoint) -> Bool {
    return lhs.hashValue == rhs.hashValue
}