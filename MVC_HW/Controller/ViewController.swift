//
//  ViewController.swift
//  MVC_HW
//
//  Created by Egor Kruglov on 06.03.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    //создаем внешнюю зависимость модели
    let model = Model()
    var alert = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //заполняем таблицу
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.toDoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
        let currentItem = model.toDoItems[indexPath.row]
        cell.itemLabel.text = currentItem.taskName
        cell.accessoryType = currentItem.completed ? .checkmark : .none
        return cell
    }
    
    //добавление нового элемента в список задач
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
    
    
    //сортировка списка задач
    @IBAction func sortButtonPressed(_ sender: Any) {
        model.sortedAscending = !model.sortedAscending
        model.sortByTitle()
        tableView.reloadData()
    }
    
    
    //функционал по выполнению задачи из списка
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if model.changeState(at: indexPath.row) == true {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
    }
    
    
    //функционал по удалению задачи из списка
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            model.toDoItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    
    //функционал по изменению задачи в списке
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] (action, view, completionHandler) in
            self?.editCellContent(indexPath: indexPath)
            completionHandler(true)
        }
        editAction.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    func editCellContent(indexPath: IndexPath) {
        
        let cell = tableView(tableView, cellForRowAt: indexPath) as! MyCell
        alert = UIAlertController(title: "Edit your task", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.addTarget(self, action: #selector(self.alertTextFieldDidChange(_:)), for: .editingChanged)
            textField.text = cell.itemLabel.text
        })
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let editAlertAction = UIAlertAction(title: "Submit", style: .default) { (createAlert) in
            guard let textFields = self.alert.textFields, textFields.count > 0 else { return }
            guard let textValue = self.alert.textFields?[0].text else { return }
            self.model.updateItem(at: indexPath.row, with: textValue)
            self.tableView.reloadData()
        }
        alert.addAction(cancelAlertAction)
        alert.addAction(editAlertAction)
        present(alert, animated: true, completion: nil)
    }
}
