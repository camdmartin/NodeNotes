//
//  DetailViewController.swift
//  NodeNotesTester
//
//  Created by Cameron Martin on 4/10/17.
//  Copyright © 2017 cmartin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

	var workspace: Workspace?
	var selectNodeButtons = [NodeSelectButton]()
	var selectedNode: Node?
	
	@IBOutlet var workspaceNavigationBar: UINavigationItem!
	
	@IBOutlet var addNewNode: UIBarButtonItem!
	
	@IBAction func addNode(_ sender: UIBarButtonItem) {
		let n = workspace!.createNode()
		
		//once moving nodes is in, change this to add at a static location
		n.location = getRandomPointInView()
			
		selectNodeButtons.append(addNodeSelectButton(node: n, x: n.location.0, y: n.location.1))
		
		self.view.setNeedsDisplay()
		//print("new button added")
	}
	
	func getRandomPointInView() -> (Int, Int) {
		let x = arc4random_uniform(UInt32(self.view.frame.width - 80)) + 40
		let y = arc4random_uniform(UInt32(self.view.frame.height - 80)) + 40
		
		return (Int(x), Int(y))
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		for btn in selectNodeButtons {
			print("node name is \(btn.associatedNode?.name)")
			btn.setTitle(btn.associatedNode?.name, for: .normal)
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	func selectNode(sender: NodeSelectButton) {
		selectedNode = sender.associatedNode
		
		guard let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "NodeViewController") as? NodeViewController else {
			print("Could not instantiate view controller with identifier of type NodeViewController")
			return
		}
		
		vc.node = selectedNode!
		self.navigationController?.pushViewController(vc, animated:true)
	}
	
	func addNodeSelectButton(node: Node, x: Int, y: Int)->NodeSelectButton {
		
		let btn: NodeSelectButton = NodeSelectButton(node: node, frame: CGRect(x: x, y: y, width: 50, height: 50))
		btn.backgroundColor = UIColor.green
		btn.setTitle(node.name, for: .normal)
		btn.addTarget(self, action: #selector(selectNode), for: .touchUpInside)
		btn.tag = 1
		self.view.addSubview(btn)
		//print("button \(node.name) added")
		
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

