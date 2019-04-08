//
//  ViewController.swift
//  LittleLabel
//
//  Created by peterlee on 2019/3/21.
//  Copyright © 2019 Personal. All rights reserved.
//

import UIKit

class LGFAnimationViewController: LGFBaseViewController,CAAnimationDelegate {
    let imageLayer = CALayer()
    var animation:CAKeyframeAnimation!
    var centerLabel:UILabel!
    var lineLayer:CAShapeLayer!
    
    var cicrleLayer:CAShapeLayer!
    var dis_Sampore:DispatchSemaphore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "创建标签"
        // Do any additional setup after loading the view.
    }
    
    override func addSubviews() {
        imageLayer.contents = UIImage(named: "res_13")?.cgImage
        imageLayer.frame = CGRect(x: 0, y: 180, width: 30, height: 30)
        self.view.layer.addSublayer(imageLayer)
        
        centerLabel = UILabel(frame: CGRect(x: 150, y: 150, width: 1, height: 1))
        centerLabel.backgroundColor = UIColor.black
        self.view.addSubview(centerLabel)
        lineLayer = CAShapeLayer()
        lineLayer.strokeColor = UIColor.black.cgColor
        lineLayer.fillColor = nil
        self.view.layer.addSublayer(lineLayer)
        lineLayer.frame = self.view.layer.bounds
        
        
        cicrleLayer = CAShapeLayer()
        cicrleLayer.strokeColor = UIColor.blue.cgColor
        cicrleLayer.lineWidth = 5
        cicrleLayer.fillColor = nil
        cicrleLayer.frame = CGRect(x: 0, y: self.view.layer.frame.height/2 - 5, width: self.view.layer.frame.width, height: self.view.layer.frame.height)
        self.view.layer.addSublayer(cicrleLayer)
        
        
    }
    override func configSubviews() {
        
        dis_Sampore = DispatchSemaphore.init(value: 1)
        DispatchQueue.global().async {
            self.dis_Sampore.wait()
            DispatchQueue.main.async {
                self.startAnimation1()
            }
        }
        DispatchQueue.global().async {
            self.dis_Sampore.wait()
            DispatchQueue.main.async {
                self.startAnimation2()
            }
        }
        
    }
    
    private func startAnimation1()
    {
        
        let transform = CGAffineTransform(translationX: 0, y: 0)
        let mutuePath = CGMutablePath()
        //        mutuePath.addArc(center: CGPoint(x: 150, y: 150), radius: 150, startAngle:  -CGFloat(Double.pi + Double.pi/4), endAngle:  -CGFloat(Double.pi + Double.pi/2), clockwise: true, transform: transform)
        mutuePath.move(to: CGPoint(x: 0, y: 150), transform: transform)
        mutuePath.addCurve(to: CGPoint(x: 150, y: 300), control1: CGPoint(x: 50, y: 300), control2: CGPoint(x: 50, y: 300), transform: transform)
        
        //        mutuePath.move(to: CGPoint(x: 150, y: 300), transform: transform)
        mutuePath.addLine(to: CGPoint(x: self.view.frame.width - 150, y: 300), transform: transform)
        //        mutuePath.move(to: CGPoint(x: self.view.frame.width - 150, y: 300), transform: transform)
        mutuePath.addCurve(to: CGPoint(x: self.view.frame.width, y: 150), control1: CGPoint(x: self.view.frame.width, y: 300), control2: CGPoint(x: self.view.frame.width, y: 300), transform: transform)
        //        mutuePath.addArc(center: CGPoint(x: self.view.frame.width - 150, y: 150), radius: 150, startAngle: -CGFloat(Double.pi*1.5), endAngle: -CGFloat(Double.pi*1.75), clockwise: true, transform: transform)
        
        
        animation = CAKeyframeAnimation(keyPath: "position")
        animation.duration = 1.5
        animation.autoreverses = true
        animation.path = mutuePath
        animation.isRemovedOnCompletion = true
        animation.delegate = self
        
        imageLayer.add(animation, forKey: "move")
        
        lineLayer.path = mutuePath
        
        let lineAnimation = CABasicAnimation(keyPath: "strokeEnd")
        lineAnimation.fromValue = 0
        lineAnimation.toValue = 1
        lineAnimation.duration = 1.5
        lineLayer.add(lineAnimation, forKey: "line")
    }
    
    private func startAnimation2()
    {
        
        let bePath = UIBezierPath.init(arcCenter: CGPoint(x: self.view.center.x, y: self.view.frame.height/4), radius: self.view.frame.height/4, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
        cicrleLayer.path = bePath.cgPath
        
        let circleAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circleAnimation.fromValue = 0
        circleAnimation.toValue = 1
        circleAnimation.duration = 1.5
        circleAnimation.delegate = self
        cicrleLayer.add(circleAnimation, forKey: "circle")
        
        
        let  animation1 = CAKeyframeAnimation(keyPath: "position")
        animation1.duration = 1.5
        animation1.autoreverses = true
        animation1.path = bePath.cgPath
        animation1.isRemovedOnCompletion = true
        animation1.delegate = self
        
        imageLayer.add(animation1, forKey: "animation1")
    }
    
    
    private func addAnimation()
    {
        imageLayer.removeAllAnimations()
        imageLayer.add(animation, forKey: "move")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        addAnimation()
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        dis_Sampore.signal()
    }
    
    
}
