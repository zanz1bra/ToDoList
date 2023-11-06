//
//  DetailViewController.swift
//  ToDoList
//
//  Created by erika.talberga on 06/11/2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectedToDo: ToDoList?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let selectedToDo = selectedToDo {
            let titleLabel = UILabel()
            titleLabel.text = selectedToDo.item
            titleLabel.frame = CGRect(x: 20, y: 100, width: 200, height: 30)
            view.addSubview(titleLabel)
            
            let subtitleLabel = UILabel()
            subtitleLabel.text = selectedToDo.subtitle
            subtitleLabel.frame = CGRect(x: 20, y: 150, width: 200, height: 30)
            view.addSubview(subtitleLabel)
        } 
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
