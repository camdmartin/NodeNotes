//
//  NodeSelectButton.swift
//  NodeNotesTester
//
//  Created by Cameron Martin on 4/12/17.
//  Copyright © 2017 cmartin. All rights reserved.
//

import UIKit

class NodeSelectButton: UIButton {
	
	var associatedNode: Node?
	
	required init(node: Node, frame: CGRect) {
		self.associatedNode = node
		
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)!
	}
	
}
