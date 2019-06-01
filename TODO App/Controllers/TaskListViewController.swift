//
//  ViewController.swift
//  TODO App
//
//  Created by Marcin Kaliniak on 30/05/2019.
//  Copyright © 2019 Marcin Kaliniak. All rights reserved.
//

import UIKit
import RealmSwift

let realm = try! Realm()
var allTasks = realm.objects(Task.self)


class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var taskTableView: UITableView!

    
    override func viewDidAppear(_ animated: Bool) {
        taskTableView.reloadData()
        checkList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTableView.delegate = self
        taskTableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TaskCell? = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TaskCell
        let currentTask = allTasks[indexPath.row]
        cell?.setValues(currentTask)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        deleteTaskAlert(tableView: tableView, indexPath: indexPath)
    }
    
    
    func checkList(){
        if allTasks.isEmpty{
            showEmptyListAlert()
        }
    }
    
    func showEmptyListAlert(){
        
        let alertController = UIAlertController(title: "EmptyList".localized, message: "EmptyListInfo".localized, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK".localized, style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func deleteTaskAlert(tableView: UITableView, indexPath: IndexPath) {

        let alertController = UIAlertController(title: "Delete?".localized, message: "DeleteInfo".localized, preferredStyle:UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: "OK".localized, style: UIAlertAction.Style.default)
        { action -> Void in
            self.deleteTask(tableView: tableView, indexPath: indexPath)
        })
        
        alertController.addAction(UIAlertAction(title: "Cancel".localized, style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func deleteTask(tableView: UITableView, indexPath: IndexPath){
        try! realm.write {
            realm.delete(allTasks[indexPath.row])
        }
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        self.checkList()
    }
}




