import UIKit

class ViewController: UIViewController {

    var touchList = [UITouch]()

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
        touchList.appendContentsOf(touches)
        // タッチイベントを取得する
        let touch = touches.first
        // タップした座標を取得する
        tapLocation = touch!.locationInView(self.view)
        touches.forEach { (touch: UITouch) in
            let point = touch.locationInView(self.view)
            drawCircle(point)
        }
    }

    func drawCircle(point: CGPoint) {
        let pi = CGFloat(M_PI)
        let start:CGFloat = 0.0 // 開始の角度
        let end :CGFloat = pi * 2.0 // 終了の角度
        
        let path: UIBezierPath = UIBezierPath();
        path.moveToPoint(point)
        path.addArcWithCenter(point, radius: 10, startAngle: start, endAngle: end, clockwise: true) // 円弧
        
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.orangeColor().CGColor
        layer.path = path.CGPath

        self.view.layer.addSublayer(layer)
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touches.forEach { (touch) in
            guard let i = touchList.indexOf(touch) else {
                return
            }
            touchList.removeAtIndex(i)
        }
    }
}
