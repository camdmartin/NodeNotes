//
//  NodeViewController.swift
//  NodeNotesTester
//
//  Created by Cameron Martin on 4/10/17.
//  Copyright © 2017 cmartin. All rights reserved.
//

import UIKit

class NodeViewController: UIViewController, UITextViewDelegate {
	
	@IBOutlet var nodeNavigationBar: UINavigationItem!
	
	@IBOutlet var nodeTextView: UITextView!
	
	var node = Node(name: "Default", value: -1)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		nodeNavigationBar.title = node.name
	}
	
	override func viewWillDisappear(_ animated : Bool) {
		super.viewWillDisappear(animated)
		
		if (self.isMovingFromParentViewController) {
			node.text = nodeTextView.text
			print("returning to workspace")
		}
	}
	
	override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
		node.text = nodeTextView.text
		let detail = subsequentVC as! DetailViewController
		detail.workspace?.updateNode(node: node)
		print("unwind segue triggered")
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func textViewDidChange(_ textView: UITextView) {
		node.text = textView.text
		print("text changed to \(textView.text)")
	}
	
}
