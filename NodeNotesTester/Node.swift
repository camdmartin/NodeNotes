//
//  Node.swift
//  NodeNotesTester
//
//  Created by Cameron Martin on 4/12/17.
//  Copyright © 2017 cmartin. All rights reserved.
//

import Foundation
import UIKit

class Node: Hashable {
	
	var name: String
	var text: String
	var links: [Node]
	var location: CGPoint
	var color = UIColor.lightGray
	var size = 50
	var fontSize = 12
	
	//this gives the node a workspace-unique identifier; the workspace has a counter and method that assigns this
	var hashValue: Int
	
	init (name: String, text: String, links: [Node], value: Int, location: CGPoint) {
		self.name = name
		self.text = text
		self.links = links
		self.hashValue = value
		self.location = location
	}
	
	//convenience initializer for empty node
	init(name: String, value: Int) {
		self.name = name
		self.text = "Insert text here"
		self.links = []
		self.hashValue = value
		self.location = CGPoint.zero
	}
		
	static func == (lhs: Node, rhs: Node) -> Bool {
		return lhs.hashValue == rhs.hashValue
	}
}
