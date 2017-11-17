//
//  AuthorTableViewController.swift
//  BookApp
//
//  Created by Patrick Hayes on 11/16/17.
//  Copyright © 2017 Patrick Hayes. All rights reserved.
//

import UIKit
import CoreData

class AuthorTableViewController: UITableViewController, AddAuthorDelegate {
    
    var author = [Author]()
    var managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var addButton: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return author.count
//    }

    
    //Required for table views++++++++++++++++++++++++++++++++++++
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return author.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listAuthorCell", for: indexPath)
        
        cell.textLabel?.text = author[indexPath.row].name!
        return cell
    }
   //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    //selecting a cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let author = self.author[indexPath.row]
        performSegue(withIdentifier: "ShowBookList", sender: author)
        //print("Cell Selected")
    }
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    //Grabbing authors from coredata and adding to array
    func fetchAllItems(){
        
        let fetchRequest: NSFetchRequest<Author> = Author.fetchRequest()
        let firstSort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [firstSort]
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Author")
        do {
//            let result = try managedObjectContext.fetch(request)
            let result = try managedObjectContext.fetch(fetchRequest)
            author = result
//            author = result as! [Author]
        } catch {
            print("\(error)")
        }
        
    }
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    //Cancel button on segue AddAuthorViewController
    func cancelButtonPressed(by controller: AddAuthorViewController) {
        print("Cancelling the add author controller")
        dismiss(animated: true, completion: nil)
    }
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    //Prepare, MUST BE INCLUDED IN ORDER TO SEND TO INFO TO NEW SEGUE AND HAVE NAV BAR WORK IN NEW SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addAuthorSegue"{
            let navigationController = segue.destination as! UINavigationController
            let addAuthorCont = navigationController.topViewController as! AddAuthorViewController
            addAuthorCont.delegate = self
        } else if segue.identifier == "ShowBookList" {
            let navigationController = segue.destination as! UINavigationController
            let bookListTableViewController = navigationController.topViewController as! BookListTableViewController

            bookListTableViewController.author = sender as! Author
        }
    }
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    //Adding Author to coredata
    func authorSaved(by controller: AddAuthorViewController, with text: String, at indexPath: NSIndexPath?){
        
        if let ip = indexPath {
            let author = self.author[ip.row]
            author.name = text
        } else {
            
            let author = NSEntityDescription.insertNewObject(forEntityName: "Author", into: managedObjectContext) as! Author
            author.name = text
            self.author.append(author)
            
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        
        tableView.reloadData()
        
        dismiss(animated: true, completion: nil)
    }
    
    //++++++++++++++++++++++++++++++++++++++++++++++
    
    //delete function+++++++++++++++++++++++++++++++
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let a = author[indexPath.row]
        managedObjectContext.delete(a)
        
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        author.remove(at: indexPath.row)
        tableView.reloadData()
        
    }
    //++++++++++++++++++++++++++++++++++++++++++++++
}
