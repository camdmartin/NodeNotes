//
//  NodeSelectButton.swift
//  NodeNotesTester
//
//  Created by Cameron Martin on 4/12/17.
//  Copyright © 2017 cmartin. All rights reserved.
//

import UIKit

class NodeSelectButton: UIButton {
	
	var node: Node?
	
	required init(node: Node, frame: CGRect) {
		self.node = node
		
		super.init(frame: frame)
		self.isUserInteractionEnabled = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)!
	}
	
	func setNodeTitleFontSize() {
		
		let titleLength = Int((node?.name.characters.count)!)
		var fontSize = 8
		
		switch titleLength {
		case 0..<4:
			fontSize = 20
		case 4..<6:
			fontSize = 14
		case 6..<9:
			fontSize = 12
		default:
			fontSize = 8
		}
		
		self.titleLabel?.font = UIFont(name: "HelveticaNeue", size: CGFloat(fontSize))
		
		self.setNeedsDisplay()
	}
	
}
