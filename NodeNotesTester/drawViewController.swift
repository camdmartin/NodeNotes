//
//  drawViewController.swift
//  NodeNotesTester
//
//  Created by Samuil Agranovich on 5/29/17.
//  Copyright © 2017 cmartin. All rights reserved.
//

import Foundation
import UIKit

class drawViewController: UIViewController {
    
    @IBOutlet var tempView: TempCanvasView!
    
    
    @IBOutlet var drawingView: drawView!
    
    var lastPoint = CGPoint.zero
    var swiped = false
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        lastPoint = (touches.first?.location(in: self.view))!
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        let currentPoint = touches.first?.location(in: self.view)
        drawLineFrom(fromPoint: lastPoint, toPoint: currentPoint!)
        lastPoint = currentPoint!
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if !swiped {
            drawLineFrom(fromPoint: lastPoint, toPoint: lastPoint)
        }
        
        UIGraphicsBeginImageContext(view.frame.size)
        
        drawingView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        tempView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        drawingView.image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        tempView.image = nil
    }
    
    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        UIGraphicsBeginImageContext(view.frame.size)
        tempView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.move(to: fromPoint)
        context?.addLine(to: toPoint)
        
        context?.setLineCap(.round)
        context?.setLineWidth(10.0)
        
        context?.strokePath()
        
        tempView.image = UIGraphicsGetImageFromCurrentImageContext()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawingView.drawMap()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

