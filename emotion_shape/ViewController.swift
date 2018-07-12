//
//  ViewController.swift
//  emotion_shape
//
//  Created by Yoshua Elmaryono on 12/07/18.
//  Copyright © 2018 Yoshua Elmaryono. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var triangle: TriangleView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 60/255, alpha: 1)
        
        triangle = TriangleView(frame: CGRect(x: view.center.x - 10, y: 220, width: 15 , height: 300))
        triangle.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
    }

    @IBOutlet weak var square: UIView!
    @IBAction func doAnimation(_ sender: UITapGestureRecognizer) {
        square.backgroundColor = UIColor(red: 255/255, green: 208/255, blue: 140/255, alpha: 1)
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = UIColor(red: 124/255, green: 124/255, blue: 108/255, alpha: 1)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                UIView.animate(withDuration: 1, animations: {
                    self.view.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 60/255, alpha: 1)
                })
            }
        }
        UIView.animate(withDuration: 2) {
            self.square.backgroundColor = UIColor.red
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // change 2 to desired number of seconds
                UIView.animate(withDuration: 1, animations: {
                    self.square.backgroundColor = UIColor.black
                    self.view.addSubview(self.triangle)
                    self.generateBubbles()
                    for _ in 0..<20{
                        self.makeOneBubble()
                    }
                })
            }
        }
    }
    
    func makeOneBubble(){
        let diameter = 18
        let x = arc4random_uniform(UInt32(view.frame.maxX - 100))
        let y = arc4random_uniform(UInt32(220 - CGFloat(diameter)))
        
        let bubbleFrame = CGRect(x: Int(x) + 50, y: Int(y), width: diameter, height: diameter)
        let bubbleView: UIView! = UIView(frame: bubbleFrame)
        bubbleView.layer.cornerRadius = CGFloat(diameter)/2
        bubbleView.backgroundColor = UIColor.red
        view.addSubview(bubbleView)
    }
    func generateBubbles(){
        var _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(makeBubbleDrop), userInfo: nil, repeats: true)
    }
    @objc func makeBubbleDrop(){
        let diameter = 15
        let y = 500
        let x = view.center.x - 10
        
        let bubbleFrame = CGRect(x: Int(x), y: Int(y), width: diameter, height: diameter)
        var bubbleView: UIView! = UIView(frame: bubbleFrame)
        bubbleView.layer.cornerRadius = CGFloat(diameter)/2
        bubbleView.backgroundColor = UIColor.red
        view.addSubview(bubbleView)
        
        
        UIView.animate(
            withDuration: 1,
            delay: 0,
            options: .curveLinear,
            animations: {
                bubbleView.frame = CGRect(x: Int(x), y: Int(self.view.frame.maxY + 20), width: diameter, height: diameter)
            },
            completion: { finished in
                bubbleView.removeFromSuperview()
                bubbleView = nil
            }
        )
    }
}

class TriangleView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.maxY))
        context.closePath()
        
        context.setFillColor(red: 92/255, green: 8/255, blue: 20/225, alpha: 1)
        context.fillPath()
    }
}
