//
//  TaskCell.swift
//  TODO App
//
//  Created by Marcin Kaliniak on 30/05/2019.
//  Copyright © 2019 Marcin Kaliniak. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var date: UILabel!
    
    
    func setValues(_ task: Task) {
        let category = task.category
        
        taskName.text = task.name
        date.text = task.date
        
        switch category {
        case "Praca":
            icon.image = #imageLiteral(resourceName: "praca")
            backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        case "Zakupy":
            icon.image = #imageLiteral(resourceName: "zakupy")
            backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        case "Dom":
            icon.image = #imageLiteral(resourceName: "dom")
            backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        default:
            icon.image = #imageLiteral(resourceName: "inne")
            backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
    }
}
