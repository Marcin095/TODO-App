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


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!

    
    override func viewDidAppear(_ animated: Bool) {
        emptyListAlert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTasks.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TaskCell? = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TaskCell
        let currentTask = allTasks[indexPath.row]
        let category = currentTask.category

        cell?.taskName.text = currentTask.name
        cell?.date.text = currentTask.date

        switch category {
        case "Praca":
            cell?.icon.image = #imageLiteral(resourceName: "praca")
            cell?.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        case "Zakupy":
            cell?.icon.image = #imageLiteral(resourceName: "zakupy")
            cell?.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        case "Dom":
            cell?.icon.image = #imageLiteral(resourceName: "dom")
            cell?.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        default:
            cell?.icon.image = #imageLiteral(resourceName: "inne")
            cell?.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        deleteTaskAlert(index: indexPath.row)
    }
    
    
    func emptyListAlert(){
        
        if(allTasks.isEmpty){
            let alertController = UIAlertController(title: "Pusta lista :(", message: "Lista zadań jest pusta. Aby dodać zadania do listy naciśnij niebieski przycisk \"+\" w prawym dolnym rogu. ", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    func deleteTaskAlert(index: Int) {
        
        let alertController = UIAlertController(title: "Usunąć?", message: "Czy na pewno chcesz usunąć wpis?", preferredStyle:UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        { action -> Void in
            try! realm.write {
                realm.delete(allTasks[index])
            }
            self.myTableView.reloadData()
            self.emptyListAlert()
        })
        
        alertController.addAction(UIAlertAction(title: "Anuluj", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

