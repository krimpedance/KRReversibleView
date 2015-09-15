//
//  ViewController.swift
//  KRReversibleViewDEMO
//
//  Created by Krimpedance on 2015/09/10.
//  Copyright (c) 2015年 Krimpedance. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var reversibleView: KRReversibleView!
    @IBOutlet weak var durationSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Front View
        let v1 = UIView(frame: self.reversibleView.bounds)
        v1.backgroundColor = UIColor.redColor()
        var label = UILabel(frame: CGRectMake(v1.frame.size.width/2-50, 100, 100, 100))
        label.text = "frontView"
        label.textAlignment = .Center
        v1.addSubview(label)
    
        // Back View
        let v2 = UIView(frame: self.reversibleView.bounds)
        v2.backgroundColor = UIColor.yellowColor()
        label = UILabel(frame: CGRectMake(v1.frame.size.width/2-50, 100, 100, 100))
        label.textAlignment = .Center
        label.text = "backView"
        v2.addSubview(label)
        
        // set views
        self.reversibleView.setViews(frontView: v1, backView: v2)
    }
    
    
    // Action -----------------
    @IBAction func bottomTopBtnTaped(sender: AnyObject) {
        self.reversibleView.makeViewReversed(duration: Double(self.durationSlider.value), rotate: .ROTATE_BT)
    }
    
    @IBAction func topBottomBtnTaped(sender: AnyObject) {
        self.reversibleView.makeViewReversed(duration: Double(self.durationSlider.value), rotate: .ROTATE_TB)
    }
    
    @IBAction func leftRightBtnTaped(sender: AnyObject) {
        self.reversibleView.makeViewReversed(duration: Double(self.durationSlider.value), rotate: .ROTATE_LR)
    }
    
    @IBAction func rightLeftBtnTaped(sender: AnyObject) {
        self.reversibleView.makeViewReversed(duration: Double(self.durationSlider.value), rotate: .ROTATE_RL)
    }
    // --------------------------
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}