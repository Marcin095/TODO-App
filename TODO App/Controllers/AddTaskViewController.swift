//
//  TaskViewController.swift
//  TODO App
//
//  Created by Marcin Kaliniak on 30/05/2019.
//  Copyright © 2019 Marcin Kaliniak. All rights reserved.
//

import UIKit
import RealmSwift


class AddTaskViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var taskNameField: UITextField!
    @IBOutlet weak var categoryNamePicker: UIPickerView!
    
    var taskName: String?
    var selectedCategory: String?
    var selectedDate: String?
    var task: Task?
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDateFormatter()
    }
    
    
    @IBAction func dataPickerValueChange(_ sender: Any) {
        selectedDate = dateFormatter.string(from: (sender as AnyObject).date)
    }
    
    
    @IBAction func saveTask(_ sender: Any) {
        
        if selectedCategory == nil{
            selectedCategory = Category.allValues[0].rawValue
        }

        if let taskName = taskNameField.text, taskName != "", let selectedDate = selectedDate{
            task = Task()
            task?.name = taskName
            task?.category = selectedCategory!
            task?.date = selectedDate
            task?.dateToSort = dateFormatter.date(from: selectedDate)

            try! realm.write {
                realm.add(task!)
            }
            allTasks = allTasks.sorted(byKeyPath: "dateToSort")
        
            showAlert(isAdded: true, title: "Success".localized, message: "DataCorrect".localized)
        }else{
            showAlert(isAdded: false, title: "DataIncorrect".localized, message: "DataIncorrectInfo".localized)
        }
    }
    
    @IBAction func backToTaskList(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showAlert(isAdded: Bool, title: String, message: String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle:UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: "OK".localized, style: UIAlertAction.Style.default)
        { action -> Void in
            if(isAdded){
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setDateFormatter(){
        dateFormatter.locale = Locale(identifier: "pl_PL")
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Category.allValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return Category.allValues[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = Category.allValues[row].rawValue
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
