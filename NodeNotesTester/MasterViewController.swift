//
//  MasterViewController.swift
//  NodeNotesTester
//
//  Created by Cameron Martin on 4/10/17.
//  Copyright © 2017 cmartin. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

	var detailViewController: DetailViewController? = nil
	var objects = [Workspace]()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.navigationItem.leftBarButtonItem = self.editButtonItem

		let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
		self.navigationItem.rightBarButtonItem = addButton
		if let split = self.splitViewController {
		    let controllers = split.viewControllers
		    self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
		}
	}

	override func viewWillAppear(_ animated: Bool) {
		self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
		super.viewWillAppear(animated)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		tableView.reloadData()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func insertNewObject(_ sender: Any) {
		let newWorkspace = Workspace(name: "New Workspace")
		renameChart(workspace: newWorkspace)
		//newWorkspace.addTestData()
		
		objects.insert(newWorkspace, at: 0)
		let indexPath = IndexPath(row: 0, section: 0)
		self.tableView.insertRows(at: [indexPath], with: .automatic)
	}
	
	func renameChart(workspace: Workspace) {
		var alertController: UIAlertController?
		alertController = UIAlertController(title: "Rename", message: "", preferredStyle: .alert)
		alertController!.addTextField { (textField: UITextField) in
			textField.placeholder = workspace.name
		}
		
		let renameAction = UIAlertAction(title: "OK", style: .default) { (paramAction:UIAlertAction!) in
			workspace.name = (alertController?.textFields?[0].text)!
			self.tableView.reloadData()
		}
		
		alertController?.addAction(renameAction)
		
		self.present(alertController!, animated: true, completion: nil)
	}

	// MARK: - Segues

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showDetail" {
		    if let indexPath = self.tableView.indexPathForSelectedRow {
		        let workspace = objects[indexPath.row]
		        let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
				controller.workspace = workspace
				controller.workspaceNavigationBar.title = workspace.name
				
				for n in workspace.nodes {
					controller.selectNodeButtons.append(controller.addNodeSelectButton(node: n, point: n.location))
				}
				
		        controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
		        controller.navigationItem.leftItemsSupplementBackButton = true
		    }
		}
	}

	// MARK: - Table View

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return objects.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

		let object = objects[indexPath.row]
		cell.textLabel!.text = object.name
		return cell
	}

	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		// Return false if you do not want the specified item to be editable.
		return true
	}

	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
		    objects.remove(at: indexPath.row)
		    tableView.deleteRows(at: [indexPath], with: .fade)
		} else if editingStyle == .insert {
		    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
		}
	}


}

