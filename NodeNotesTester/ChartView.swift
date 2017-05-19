//
//  ChartView.swift
//  NodeNotesTester
//
//  Created by Cameron Martin on 5/19/17.
//  Copyright © 2017 cmartin. All rights reserved.
//

import Foundation
import UIKit

class ChartView: UIView {
	
	var nodes: [Node]? = nil
	
	override func draw(_ rect: CGRect) {
		
		for n in nodes! {
			for l in n.links {
				let line = UIBezierPath()
				
				line.move(to: n.getNodeCenter())
				
				line.addLine(to: l.getNodeCenter())
				
				line.close()
				
				line.lineWidth = 2.0
				
				line.stroke()
			}
		}
	}
}

