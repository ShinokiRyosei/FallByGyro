//
//  ViewController.swift
//  FreeFallandGyro
//
//  Created by Life is Tech on 17/6/15.
//  Copyright (c) 2015 shinokiryosei. All rights reserved.
//

import UIKit
import CoreMotion


class ViewController: UIViewController {
//    UIViewをArrayで宣言
    @IBOutlet var balls: [UIView]!
//    ダイナミックアニメーターをプロパティとして宣言
    var dynamicAnimator: UIDynamicAnimator!
//    CMMotionManagerをプロパティとして宣言
    let motionManager = CMMotionManager()
    
    var deviceMotion = CMDeviceMotion()
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.startGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startGame() {
        self.motionManager.deviceMotionUpdateInterval = 1.0 / 10.0
        
        

        
        let gravityBehavior = UIGravityBehavior(items: self.balls)
        
        let collisionBehavior = UICollisionBehavior(items: self.balls)
        
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        
        
        
        
        dynamicAnimator.addBehavior(gravityBehavior)
        dynamicAnimator.addBehavior(collisionBehavior)
        
        self.motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: {(deviceMotion: CMDeviceMotion!, error: NSError!) in
            //        ジャイロスコープの角度を取得
            let x = CGFloat(deviceMotion.attitude.roll)
            let y = CGFloat(deviceMotion.attitude.pitch)
            
            NSLog("取得したx軸の角度は...%f", x)
            NSLog("取得したy軸の角度は...%f", y)
            gravityBehavior.gravityDirection = CGVectorMake(x, y)
            gravityBehavior.magnitude = 0.5})
    }


}

