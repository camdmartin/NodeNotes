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
	
	var nodes: [Node]?
	var selectedNode: NodeSelectButton?
	var temporaryNode: CGPoint?
	
	override func draw(_ rect: CGRect) {
		
		for n in nodes! {
			for l in n.links {
				drawNodeLink(from: n.getNodeCenter(), to: l.getNodeCenter())
			}
		}
		
		if let t = temporaryNode, let s = selectedNode?.node {
			drawNodeLink(from: s.getNodeCenter(), to: t)
		}
	}
	
	func drawNodeLink(from: CGPoint, to: CGPoint) {
		let line = UIBezierPath()
		
		line.move(to: from)
		
		line.addLine(to: to)
		
		line.close()
		
		line.lineWidth = 2.0
		
		line.stroke()
	}
}

