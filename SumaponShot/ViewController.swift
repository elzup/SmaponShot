import UIKit

class ViewController: UIViewController {

    var touchList = [TouchPoint]()
    var circleLayers = [CAShapeLayer]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.multipleTouchEnabled = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var tapLocation: CGPoint = CGPoint()

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touchList.appendContentsOf(touches.map({ (touch: UITouch) -> TouchPoint in
            return TouchPoint(touch: touch)
        }))
        drawUpdate()
    }

    func drawUpdate() {
        for layer in circleLayers {
            layer.removeFromSuperlayer()
        }
        if touchList.count % 3 == 0 {
            for tps in groupingPoint(self.touchList) {
                for touch in tps.touchPoints {
                    let point = touch.touch.locationInView(self.view)
                    drawCircle(point)
                }
            }
        }
    }

    func groupingPoint(touches: [TouchPoint]) -> [TouchPointSet] {
        let sorted = touches.sort { (u1: TouchPoint, u2: TouchPoint) -> Bool in
            u1.timestamp - u2.timestamp > 0
        }
        var sets = [TouchPointSet]()
        var touchSet = Set<TouchPoint>()
        for tp in sorted {
            touchSet.insert(tp)
            if touchSet.count == 3 {
                sets.append(TouchPointSet(touchPoints: touchSet))
                touchSet.removeAll()
            }
        }
        return sets
    }

    func drawCircle(point: CGPoint) {
        let pi = CGFloat(M_PI)
        let start:CGFloat = 0.0 // 開始の角度
        let end :CGFloat = pi * 2.0 // 終了の角度
        
        let path: UIBezierPath = UIBezierPath();
        path.moveToPoint(point)
        path.addArcWithCenter(point, radius: 100, startAngle: start, endAngle: end, clockwise: true) // 円弧
        
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.orangeColor().CGColor
        layer.path = path.CGPath

        self.view.layer.addSublayer(layer)
        circleLayers.append(layer)
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touches.forEach { (touch) in
            guard let i = touchList.map({ (tp: TouchPoint) -> UITouch in
                return tp.touch
            }).indexOf(touch) else {
                return
            }
            touchList.removeAtIndex(i)
        }
        drawUpdate()
    }
}
