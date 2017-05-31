//
//  Node.swift
//  NodeNotesTester
//
//  Created by Cameron Martin on 4/12/17.
//  Copyright © 2017 cmartin. All rights reserved.
//

import Foundation
import UIKit

class Node: Hashable, CustomStringConvertible {
	
	var name: String
	var text: String
	var links: Set<Node>
	var location: CGPoint
	var color = UIColor.lightGray
	var size = 100
	var fontSize = 12
	var drawnImage = UIImage()
	
	var description: String {
		return "\(name): size \(size), location (\(location.x), \(location.y))"
	}
	
	//this gives the node a workspace-unique identifier; the workspace has a counter and method that assigns this
	var hashValue: Int
	
	init (name: String, text: String, links: Set<Node>, value: Int, location: CGPoint) {
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
	
	func getNodeCenter() -> CGPoint {
		return CGPoint(x: Int(location.x) + size / 2, y: Int(location.y) + size / 2)
	}
		
	static func == (lhs: Node, rhs: Node) -> Bool {
		return lhs.hashValue == rhs.hashValue
	}
}
