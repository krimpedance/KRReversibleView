//
//  KRReversibleView.swift
//
//  Created by Krimpedance on 2015/09/10.
//  Copyright (c) 2015年 Krimpedance. All rights reserved.
//

import UIKit

enum RotateDirection {
    case ROTATE_LR // left to right
    case ROTATE_RL // right to left
    case ROTATE_TB // top to bottom
    case ROTATE_BT // bottom to top
}

class KRReversibleView: UIView {
    @IBInspectable var isFront :Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.clipsToBounds = true
    }
    
    convenience init(frame: CGRect!, frontView: UIView!, backView: UIView!) {
        self.init(frame: frame)
        
        self.setViews(frontView: frontView, backView: backView)
    }
   
    
    /**
    front, backView の設定
    */
    func setViews(frontView frontView :UIView?, backView :UIView?) {
        // subViewの削除
        for v in self.subviews {
            v.removeFromSuperview()
        }
        
        // self の中心座標
        let centerPoint = CGPointMake(self.frame.width/2, self.frame.height/2)
 
        // frontView があれば追加
        if let v = frontView {
            v.center = centerPoint
            v.tag = 5000
            self.addSubview(v)
            
            if (!self.isFront) { v.hidden = true }
        }
        
        // backView があれば追加
        if let v = backView {
            v.center = centerPoint
            v.tag = 5001
            self.addSubview(v)

            if (self.isFront) { v.hidden = true }
        }
        
        
        var theTransform :CATransform3D = self.layer.sublayerTransform
        theTransform.m34 = 1 / -500
        self.layer.transform = theTransform
    }
    
    
    /**
    Get views
    
    - returns: [FrontView, BackView]
    */
    func getViews() -> [UIView]? {
        var frontView :UIView?
        var backView :UIView?
        
        // frontView, backView を取得
        for v in self.subviews {
            if (v.tag == 5000) { frontView = v }
            if (v.tag == 5001) { backView = v }
        }
        
        // どちらかのビューが欠けてる
        guard case let (f?, b?) = (frontView, backView) else {
            return nil
        }
        
        return [f, b]
    }
    
    
    /**
    Make view reversed
    */
    func makeViewReversed(duration duration :NSTimeInterval = 0.5, rotate :RotateDirection = .ROTATE_RL) {
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        // If views is broken off, nothing is done.
        guard let views = self.getViews() else {
            print("You must set Views.")
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            return
        }
        
        let frontView :UIView = views[0]
        let backView :UIView = views[1]
        
        if (duration == 0) {
            // change display view
            if (self.isFront) {
                self.isFront = false
                frontView.hidden = true
                backView.hidden = false
            } else {
                self.isFront = true
                frontView.hidden = false
                backView.hidden = true
            }
            
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            return
        }
        
        // The coordinate to decide the direction of rotation
        let x: CGFloat
        let y: CGFloat
        
        switch rotate {
        case .ROTATE_LR :
            x = 0
            y = 1
            
        case .ROTATE_RL :
            x = 0
            y = -1
            
        case .ROTATE_TB :
            x = -1
            y = 0
            
        case .ROTATE_BT :
            x = 1
            y = 0
        }
        
        UIView.animateWithDuration(duration/2, animations: { () -> Void in
            //rotate 90˚
            self.layer.transform = CATransform3DRotate(self.layer.transform, CGFloat(M_PI_2), x, y, 0)
        }) { (Bool) -> Void in
            //rotate 270˚ without animation
            self.layer.transform = CATransform3DRotate(self.layer.transform, CGFloat(M_PI), x, y, 0)
            
            // change display view
            if (self.isFront) {
                self.isFront = false
                frontView.hidden = true
                backView.hidden = false
            } else {
                self.isFront = true
                frontView.hidden = false
                backView.hidden = true
            }
            
            // rotate 360˚
            UIView.animateWithDuration(
                duration/2,
                animations: { () -> Void in
                    self.layer.transform = CATransform3DRotate(self.layer.transform, CGFloat(M_PI_2), x, y, 0)
                }) { (Bool) -> Void in
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
            }
        }
    }
}