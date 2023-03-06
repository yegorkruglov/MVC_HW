//
//  ViewController.swift
//  MVC_HW
//
//  Created by Egor Kruglov on 06.03.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let model = Model()
    
    var alert = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.toDoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
        let currentItem = model.toDoItems[indexPath.row]
        cell.itemLabel.text = currentItem.taskName
        return cell
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        alert = UIAlertController(title: "Create new task", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Put your task here"
            textField.addTarget(self, action: #selector(self.alertTextFieldDidChange(_:)), for: .editingChanged)
        }
        
        let createAlertAction = UIAlertAction(title: "Create", style: .default) { (createAlert) in
            guard let unwrTextFieldValue = self.alert.textFields?[0].text else { return }
            self.model.addItem(taskName: unwrTextFieldValue)
            self.tableView.reloadData()
        }
        
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAlertAction)
        alert.addAction(createAlertAction)
        present(alert, animated: true, completion: nil)
        createAlertAction.isEnabled = false
        
    }
    
    @objc func alertTextFieldDidChange(_ sender: UITextField) {
        
        guard let senderText = sender.text, alert.actions.indices.contains(1) else { return }
        let action = alert.actions[1]
        action.isEnabled = senderText.count > 0
    }
    
    @IBAction func sortButtonPressed(_ sender: Any) {
        model.sortedAscending = !model.sortedAscending
        model.sortByTitle()
        tableView.reloadData()
    }
    
}
