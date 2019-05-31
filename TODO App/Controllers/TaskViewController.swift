//
//  TaskViewController.swift
//  TODO App
//
//  Created by Marcin Kaliniak on 30/05/2019.
//  Copyright © 2019 Marcin Kaliniak. All rights reserved.
//

import UIKit
import RealmSwift



class TaskViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var taskNameField: UITextField!
    @IBOutlet weak var categoryNamePicker: UIPickerView!
    
    let categories = ["Praca", "Zakupy", "Dom", "Inne"]
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
        print(selectedDate!)
    }
    
    
    @IBAction func saveTask(_ sender: Any) {
        
        if let taskName = taskName, taskName != "", let selectedCategory = selectedCategory, let selectedDate = selectedDate{
            print("SUKCES!!!")
            
            task = Task()
            task?.name = taskName
            task?.category = selectedCategory
            task?.date = selectedDate

            try! realm.write {
                realm.add(task!)
            }
//            var allTasks = Array(results)
//            allTasks.sort(by: {dateFormatter.date(from: $0.date!)! < dateFormatter.date(from: $1.date!)! })
            
            getAlert(title: "Sukces!", message: "Dane zostały zapisane prawidłowo.")
        }else{
            getAlert(title: "Niepoprawne dane", message: "Wprowadzone dane są niepoprawne lub nie zostały wprowadzone. Proszę uzupełnić wszystkie wartości.")
        }
    }
    
    
    func getAlert(title: String, message: String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle:UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        { action -> Void in
            if(title == "Sukces!"){
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                self.present(viewController, animated: true, completion: nil)
            }
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setDateFormatter(){
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categories[row]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if let taskName = textField.text{
            self.taskName = taskName
        }
    }
}
