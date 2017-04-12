//
//  Workspace.swift
//  NodeNotesTester
//
//  Created by Cameron Martin on 4/12/17.
//  Copyright © 2017 cmartin. All rights reserved.
//

import Foundation

class Workspace {
	
	//contains Nodes and their locations in x-y space
	var name: String
	var nodeDict: [Node: (Int, Int)]
	var nodeHashCounter = 0
	
	init(name: String) {
		self.name = name
		nodeDict = [:]
	}
	
	func createNode() {
		let newNode = Node(name: "New", value: nodeHashCounter)
		
		nodeDict[newNode] = (0, 0)
	}
	
}
