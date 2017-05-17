//
//  DetailViewController.swift
//  NodeNotesTester
//
//  Created by Cameron Martin on 4/10/17.
//  Copyright © 2017 cmartin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIGestureRecognizerDelegate {
	
	var workspace: Workspace?
	var selectNodeButtons = [NodeSelectButton]()
	var selectedNode: Node?
	let defaultNodeSize = 50
	
	@IBOutlet var renameButton: UIBarButtonItem!
	
	@IBOutlet var toolbar: UIToolbar!
	
	@IBOutlet var workspaceNavigationBar: UINavigationItem!
	
	@IBOutlet var addNewNode: UIBarButtonItem!
	
	@IBAction func addNode(_ sender: UIBarButtonItem) {
		let n = workspace!.createNode()
		
		//once moving nodes is in, change this to add at a static location
		n.location = CGPoint(x: Int(self.toolbar.frame.width / 2) - defaultNodeSize / 2, y: 100)
		
		selectNodeButtons.append(addNodeSelectButton(node: n, point: n.location))
		
		self.view.setNeedsDisplay()
		//print("new button added")
	}
	
	@IBAction func renameChart(_ sender: UIBarButtonItem) {
		var alertController: UIAlertController?
		alertController = UIAlertController(title: "Rename", message: "", preferredStyle: .alert)
		alertController!.addTextField { (textField: UITextField) in
			textField.placeholder = self.workspace?.name
		}
		
		let renameAction = UIAlertAction(title: "OK", style: .default) { (paramAction:UIAlertAction!) in
			self.workspace?.name = (alertController?.textFields?[0].text)!
			self.workspaceNavigationBar.title = self.workspace?.name
		}
		
		alertController?.addAction(renameAction)
		
		self.present(alertController!, animated: true, completion: nil)
	}
	
	func renameNodeButton(button: NodeSelectButton) {
		var alertController: UIAlertController?
		alertController = UIAlertController(title: "Rename", message: "", preferredStyle: .alert)
		alertController!.addTextField { (textField: UITextField) in
			textField.placeholder = button.associatedNode?.name
		}
		
		let renameAction = UIAlertAction(title: "OK", style: .default) { (paramAction:UIAlertAction!) in
			button.associatedNode?.name = (alertController?.textFields?[0].text)!
			button.setTitle(button.associatedNode?.name, for: .normal)
		}
		
		alertController?.addAction(renameAction)
		
		self.present(alertController!, animated: true, completion: nil)
	}
	
	func getRandomPointInView() -> CGPoint {
		let x = arc4random_uniform(UInt32(self.view.frame.width - 80)) + 40
		let y = arc4random_uniform(UInt32(self.view.frame.height - 80)) + 40
		
		return CGPoint(x: Int(x), y: Int(y))
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		for button in self.view.subviews {
			if let b = button as? NodeSelectButton {
				b.setTitle(b.associatedNode?.name, for: .normal)
				setNodeTitleFontSize(button: b)
			}
		}
		
		self.view.setNeedsDisplay()
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	func setNodeTitleFontSize(button: NodeSelectButton) {
		
		let titleLength = Int((button.associatedNode?.name.characters.count)!)
		var fontSize = 14
		
		switch titleLength {
		case 0..<4:
			fontSize = 20
		case 4..<6:
			fontSize = 14
		case 6..<9:
			fontSize = 12
		default:
			fontSize = 8
		}
		
		button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: CGFloat(fontSize))
		
		button.setNeedsDisplay()

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
	
	func addNodeSelectButton(node: Node, point: CGPoint)->NodeSelectButton {
		
		let button: NodeSelectButton = NodeSelectButton(node: node, frame: CGRect(origin: point, size: CGSize(width: defaultNodeSize, height: defaultNodeSize)))
		
		button.layer.cornerRadius = 0.5 * button.bounds.size.width
		button.layer.borderWidth = 3
		button.layer.borderColor = UIColor.gray.cgColor
		
		button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 14)
		button.setTitleColor(UIColor.black, for: .normal)
		
		button.setTitle(node.name, for: .normal)
		setNodeTitleFontSize(button: button)
		
		button.addTarget(self, action: #selector(selectNode), for: .touchUpInside)
		button.tag = 1
		
		self.view.addSubview(button)

		renameNodeButton(button: button)
		
		let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(DetailViewController.handlePan(_:)))
		gestureRecognizer.delegate = self
		button.addGestureRecognizer(gestureRecognizer)
		
		return button
	}
	
	//node dragging code
	@IBAction func handlePan(_ recognizer:UIPanGestureRecognizer) {
		let translation = recognizer.translation(in: self.view)
		if let view = recognizer.view {
			view.center = CGPoint(x:view.center.x + translation.x,
	                      y:view.center.y + translation.y)
		}
		recognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
		let button = recognizer.view as! NodeSelectButton
		button.associatedNode?.location = button.frame.origin
	}
	
}

