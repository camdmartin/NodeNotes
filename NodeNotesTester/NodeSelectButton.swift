//
//  NodeSelectButton.swift
//  NodeNotesTester
//
//  Created by Cameron Martin on 4/12/17.
//  Copyright © 2017 cmartin. All rights reserved.
//

import UIKit

class NodeSelectButton: UIButton {
	
	var associatedWorkspaceIndex: Int?
	var associatedNodeID: Int?
	
	required init(workspaceIndex: Int, nodeID: Int, frame: CGRect) {
		self.associatedWorkspaceIndex = workspaceIndex
		self.associatedNodeID = nodeID
		
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)!
	}
	
}
