//
//  BookListTableViewController.swift
//  BookApp
//
//  Created by Patrick Hayes on 11/17/17.
//  Copyright © 2017 Patrick Hayes. All rights reserved.
//

import UIKit

class BookListTableViewController: UITableViewController {

    var author: Author!
    var managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //Back button in nav bar
    @IBAction func BackButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    //+++++++
    
    //Add button in nav bar
    @IBAction func addBook(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Book", message: "Add a new Book",
                                      preferredStyle: .alert)
        let newRowIndex = self.author.books?.count
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            _ in
            let textField = alert.textFields![0]
            let newBook = Book(context: self.managedObjectContext)
            newBook.title = textField.text
            self.author.addToBooks(newBook)
            do {
                try self.managedObjectContext.save()
                print("Success!")
            } catch {
                print("Error: \(error)")
            }
            let indexPath = IndexPath(row: newRowIndex!, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {
            UIAlertAction -> Void in
        }
        alert.addTextField {
            UITextField -> Void in
        }
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    //+++++++
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = author.name //setting the title in the view controller to the author that we passed from previous view controller
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return author.books!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listBookCell", for: indexPath)
        let book = self.author.books?[indexPath.row] as! Book
        
        print("These are the books: \(self.author)")
        
        cell.textLabel?.text = book.title
        return cell
    }
    
    //delete function+++++++++++++++++++++++++++++++
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let b = self.author.books?[indexPath.row] as! Book
        managedObjectContext.delete(b)
        
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        self.author.removeFromBooks(b)
        tableView.reloadData()
        
    }
    //++++++++++++++++++++++++++++++++++++++++++++++

    
    //NS Predicate -- Filtered Searches
    
//    var pat = "pat"
//    let requestPredicate = NSPredicate(format: "author.name == %@", pat)
//    fetchRequest.predicate = requestPredicate
    

}
