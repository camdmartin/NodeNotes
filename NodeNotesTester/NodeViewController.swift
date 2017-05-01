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
	
	@IBOutlet var saveTextButton: UIBarButtonItem!
	
	@IBOutlet var nodeTextView: UITextView!
	
	var workspaceIndex: Int?
	var nodeID: Int?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		nodeNavigationBar.title = WorkspaceStore.sharedWorkspaceStore.workspaces[workspaceIndex!].nodes[nodeID!].name
		nodeTextView.text = WorkspaceStore.sharedWorkspaceStore.workspaces[workspaceIndex!].nodes[nodeID!].text
	}
	
	/*override func viewWillDisappear(_ animated : Bool) {
		super.viewWillDisappear(animated)
		
		if (self.isMovingFromParentViewController) {
			node.text = nodeTextView.text
			print("returning to workspace")
		}
	}*/
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBAction func saveText(_ sender: UIBarButtonItem) {
		resignFirstResponder()
		WorkspaceStore.sharedWorkspaceStore.workspaces[workspaceIndex!].nodes[nodeID!].text = nodeTextView.text
		print("text changed to \(WorkspaceStore.sharedWorkspaceStore.workspaces[workspaceIndex!].nodes[nodeID!].text)")
	}
	
	func textViewDidChange(_ textView: UITextView) {
		WorkspaceStore.sharedWorkspaceStore.workspaces[workspaceIndex!].nodes[nodeID!].text = textView.text
		print("text changed to \(WorkspaceStore.sharedWorkspaceStore.workspaces[workspaceIndex!].nodes[nodeID!].text)")
	}
	
}
