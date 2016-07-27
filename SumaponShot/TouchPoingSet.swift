import Foundation
import UIKit

class TouchPointSet {
    internal let touchPoints: [TouchPoint]
    var topPoint: CGPoint!
    var bottomPointA: CGPoint!
    var bottomPointB: CGPoint!

    init(touchPoints: [TouchPoint]) {
        self.touchPoints = touchPoints
        self.setupVerticals()
    }

    func setupVerticals() {
        let ps = touchPoints.map { (tp: TouchPoint) -> CGPoint in
            return tp.point
        }
        let d1: CGFloat = sqrt(pow((ps[0].x - ps[1].x), 2) + pow((ps[0].y - ps[1].y), 2))
        let d2: CGFloat = sqrt(pow((ps[1].x - ps[2].x), 2) + pow((ps[1].y - ps[2].y), 2))
        let d3: CGFloat = sqrt(pow((ps[2].x - ps[0].x), 2) + pow((ps[2].y - ps[0].y), 2))
        let dMin = min(min(d1, d2), d3)
        if d1 == dMin {
            (topPoint, bottomPointA, bottomPointB) = (ps[2], ps[0], ps[1])
        } else if d2 == dMin {
            (topPoint, bottomPointA, bottomPointB) = (ps[0], ps[1], ps[2])
        } else {
            (topPoint, bottomPointA, bottomPointB) = (ps[1], ps[2], ps[0])
        }
    }

    // 中心 point
    func centerPoint() -> CGPoint {
        // bottom 二点間
        let bottomCenterPoint = CGPoint(x: (bottomPointB.x + bottomPointA.x) / 2, y: (bottomPointB.y + bottomPointA.y) / 2)
        // bottom 二点間 と top の中間
        return CGPoint(x: (bottomCenterPoint.x + topPoint.x) / 2, y: (bottomCenterPoint.y + topPoint.y) / 2)
    }
}