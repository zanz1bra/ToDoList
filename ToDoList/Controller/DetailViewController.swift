//
//  DetailViewController.swift
//  ToDoList
//
//  Created by erika.talberga on 06/11/2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectedToDo: ToDoList?
    var titleText: String?
    var subtitleText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        titleLabel.textColor = UIColor.label
        titleLabel.font = UIFont(name: "Futura", size: 18)
        titleLabel.text = titleText
        
        let subtitleLabel = UILabel()
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitleLabel)
        
        subtitleLabel.textColor = UIColor.label
        subtitleLabel.font = UIFont(name: "Futura", size: 15)
        subtitleLabel.text = subtitleText
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
        subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        
        subtitleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        subtitleLabel.textAlignment = .center
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
