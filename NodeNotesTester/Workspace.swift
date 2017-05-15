//
//  Workspace.swift
//  NodeNotesTester
//
//  Created by Cameron Martin on 4/12/17.
//  Copyright © 2017 cmartin. All rights reserved.
//

import Foundation
import UIKit

class Workspace {
	
	//contains Nodes and their locations in x-y space
	var name: String
	var nodes: [Node]
	var nodeHashCounter = 0
	
	init(name: String) {
		self.name = name
		nodes = []
	}
	
	func createNode() -> Node {
		let newNode = Node(name: "New", value: nodeHashCounter)
		
		nodes.append(newNode)
		
		nodeHashCounter += 1
		
		return newNode
	}
	
	func updateNode(node: Node) {
		if nodes.contains(node) {
			nodes[nodes.index(of: node)!] = node
		} else {
			print("node to be updated does not exist")
		}
	}
	
	func createNodeWithName(name: String, x: Int, y: Int) {
		let newNode = Node(name: name, value: nodeHashCounter)
		newNode.location = CGPoint(x: x, y: y)
		
		nodeHashCounter += 1
		
		nodes.append(newNode)
	}
	
	func addTestData() {
		createNodeWithName(name: "Test1", x: 50, y: 50)
		createNodeWithName(name: "Test2", x: 100, y: 200)
		createNodeWithName(name: "Test3", x: 200, y: 400)
	}
}
