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
	
	let xBoundary = 30
	let yBoundary = 80
	
	@IBOutlet var renameButton: UIBarButtonItem!
	
	@IBOutlet var toolbar: UIToolbar!
	
	@IBOutlet var workspaceNavigationBar: UINavigationItem!
	
	@IBOutlet var addNewNode: UIBarButtonItem!
	
	@IBAction func addNode(_ sender: UIBarButtonItem) {
		let n = workspace!.createNode()
		
		n.location = CGPoint(x: Int(self.toolbar.frame.width / 2) - n.size / 2, y: 100)
		
		selectNodeButtons.append(addNodeSelectButton(node: n, point: n.location))
		
		self.view.setNeedsDisplay()
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
			textField.placeholder = button.node?.name
		}
		
		let renameAction = UIAlertAction(title: "OK", style: .default) { (paramAction:UIAlertAction!) in
			button.node?.name = (alertController?.textFields?[0].text)!
			button.setTitle(button.node?.name, for: .normal)
		}
		
		alertController?.addAction(renameAction)
		
		self.present(alertController!, animated: true, completion: nil)
	}
	
	//this is for creating nodes in random positions
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
				updateButton(button: b)
			}
		}
		
		self.view.setNeedsDisplay()
		
	}
	
	func updateButton(button: NodeSelectButton) {
		button.setTitle(button.node?.name, for: .normal)
		button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: CGFloat((button.node?.fontSize)!))
		
		button.layer.borderColor = button.node?.color.cgColor
		button.layer.borderWidth = 3
		
		button.frame = CGRect(origin: button.frame.origin, size: CGSize(width: button.node!.size, height: button.node!.size))
		button.layer.cornerRadius = 0.5 * button.bounds.size.width
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	func selectNode(sender: NodeSelectButton) {
		selectedNode = sender.node
		
		guard let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "NodeViewController") as? NodeViewController else {
			print("Could not instantiate view controller with identifier of type NodeViewController")
			return
		}
		
		vc.node = selectedNode!
		vc.navigationController?.navigationBar.barTintColor = vc.node.color
		self.navigationController?.pushViewController(vc, animated:true)
	}
	
	func addNodeSelectButton(node: Node, point: CGPoint)->NodeSelectButton {
		
		let button: NodeSelectButton = NodeSelectButton(node: node, frame: CGRect(origin: point, size: CGSize(width: node.size, height: node.size)))
		
		button.layer.cornerRadius = 0.5 * button.bounds.size.width
		button.layer.borderWidth = 3
		button.layer.borderColor = button.node!.color.cgColor
		
		button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: CGFloat(node.fontSize))
		button.setTitleColor(UIColor.black, for: .normal)
		
		button.setTitle(node.name, for: .normal)
		
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
			
			let viewCenter = CGPoint(x:view.center.x + translation.x,
	                      y:view.center.y + translation.y)
			let superview = view.superview!
			
			if ((CGFloat(xBoundary)) < viewCenter.x && viewCenter.x < (superview.frame.width - CGFloat(xBoundary))) {
				if (CGFloat(yBoundary) < viewCenter.y && viewCenter.y < (superview.frame.height - CGFloat(yBoundary))) {
					view.center = viewCenter
				}
			}
		}
		recognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
		let button = recognizer.view as! NodeSelectButton
		button.node?.location = button.frame.origin
	}
	
}

