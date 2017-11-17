//
//  AddAuthorViewController.swift
//  BookApp
//
//  Created by Patrick Hayes on 11/16/17.
//  Copyright © 2017 Patrick Hayes. All rights reserved.
//

import UIKit

class AddAuthorViewController: UITableViewController {

    weak var delegate: AddAuthorDelegate?
    var name: String?
    var indexPath: NSIndexPath?
    
    @IBOutlet weak var authorTextField: UITextField!
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(by: self)
        print("I pressed cancel")
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let name = authorTextField.text!
        print("I pressed save")
        delegate?.authorSaved(by: self, with: name, at: indexPath)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authorTextField.text = name
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
