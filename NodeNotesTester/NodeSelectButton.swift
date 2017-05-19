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
}
