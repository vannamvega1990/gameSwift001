//
//  stickControlView.swift
//  learnGit
//
//  Created by TRAN THONG on 4/7/22.
//

import UIKit


protocol stickDelegate {
    func stickDraging(percent: CGFloat)
    func stickTouchUp()
}

class stickControlView: UIViewController {
    
    @IBOutlet weak var viewTouch: UIView!
    @IBOutlet weak var stick: UIImageView!

    init() {
        super.init(nibName: "stickControlView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        stick_beginPoint = stick.frame.origin
        max_lui = self.view.frame.size.height - 5 * stick_beginPoint.y
    }

    var touchBeginPoint: CGPoint = .init()
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location=touch.location(in: self.viewTouch)
            touchBeginPoint = location
        }
    }
    
    var max_lui: CGFloat!
    var stick_beginPoint: CGPoint!
    var delegate: stickDelegate!
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location=touch.location(in: self.viewTouch)
            let dy1 = location.y - touchBeginPoint.y
            var frame = stick.frame
            frame.origin.y += dy1
            let dy = frame.origin.y - stick_beginPoint.y
            if dy < 0 {
                frame.origin.y = stick_beginPoint.y
            }
            else if dy > max_lui {
                frame.origin.y = stick_beginPoint.y + max_lui
            }
            stick.frame = frame
            touchBeginPoint = location
            let per = dy * 100 / max_lui
            delegate.stickDraging(percent: per)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
