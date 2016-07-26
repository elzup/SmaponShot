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
            touch.locationInView(self.view)
        }

    }

    func drawCircle(x: CGFloat, y: CGFloat) {
        let pi = CGFloat(M_PI)
        let start:CGFloat = 0.0 // 開始の角度
        let end :CGFloat = pi * 2.0 // 終了の角度
        
        let path: UIBezierPath = UIBezierPath();
        path.moveToPoint(CGPointMake(x, y))
        path.addArcWithCenter(CGPointMake(self.view.frame.width/2, self.view.frame.height/2), radius: 100, startAngle: start, endAngle: end, clockwise: true) // 円弧
        
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
