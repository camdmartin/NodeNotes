//
//  DetailViewController.swift
//  NodeNotesTester
//
//  Created by Cameron Martin on 4/10/17.
//  Copyright © 2017 cmartin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

	var workspaceIndex: Int?
	var selectNodeButtons = [NodeSelectButton]()
	var selectedNode: Node?
	
	@IBOutlet var workspaceNavigationBar: UINavigationItem!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	func selectNode(sender: NodeSelectButton) {
		selectedNode = WorkspaceStore.sharedWorkspaceStore.workspaces[sender.associatedWorkspaceIndex!].nodes[sender.associatedNodeID!]
		
		guard let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "NodeViewController") as? NodeViewController else {
			print("Could not instantiate view controller with identifier of type NodeViewController")
			return
		}
		
		vc.nodeID = sender.associatedNodeID
		vc.workspaceIndex = sender.associatedWorkspaceIndex
		self.navigationController?.pushViewController(vc, animated:true)
	}
	
	func addNodeSelectButton(workspaceIndex: Int, nodeID: Int, x: Int, y: Int)->NodeSelectButton {
		
		let btn: NodeSelectButton = NodeSelectButton(workspaceIndex: workspaceIndex, nodeID: nodeID, frame: CGRect(x: x, y: y, width: 50, height: 50))
		btn.backgroundColor = UIColor.green
		let nodeName = WorkspaceStore.sharedWorkspaceStore.workspaces[workspaceIndex].nodes[nodeID].name
		
		btn.setTitle(nodeName, for: .normal)
		btn.addTarget(self, action: #selector(selectNode), for: .touchUpInside)
		btn.tag = 1
		self.view.addSubview(btn)
		print("button \(nodeName) added")
		
		return btn
	}
	
	// MARK: - Segues
	
	/*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showNode" {
			let controller = (segue.destination as! UINavigationController).topViewController as! NodeViewController
			if let n = selectedNode {
				controller.node = n
				controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
				controller.navigationItem.leftItemsSupplementBackButton = true
			}
			
		}
	}*/

}

