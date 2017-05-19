//
//  WorkspaceDataSource.swift
//  NodeNotesTester
//
//  Created by Cameron Martin on 5/1/17.
//  Copyright © 2017 cmartin. All rights reserved.
//

import Foundation

class WorkspaceDataSource {
	
	var workspaces = [Workspace]()
	
}

protocol WorkspaceDataSourceDelegate {
	
	func updateNode(workspaceID: Int, nodeID: Int)
	
}
