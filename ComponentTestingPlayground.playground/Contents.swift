//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import SnapKit
import habitapp_framework

class MyViewController : UIViewController {
    override func loadView() {
        
        let frame = CGRect(x: 0,
                           y: 0,
                           width: 200,
                           height: 200)
        let circleView = CircleProgressView(frame: frame)
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor.red
        self.view = circleView
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

