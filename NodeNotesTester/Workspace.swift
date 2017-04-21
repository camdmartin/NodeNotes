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
	
	func createNodeWithName(name: String, x: Int, y: Int) {
		let newNode = Node(name: name, value: nodeHashCounter)
		
		nodeHashCounter += 1
		
		nodeDict[newNode] = (x, y)
	}
	
	func addTestData() {
		createNodeWithName(name: "Test1", x: 50, y: 50)
		createNodeWithName(name: "Test2", x: 100, y: 200)
		createNodeWithName(name: "Test3", x: 200, y: 400)
	}
}
