//
//  AddBookDelegate.swift
//  BookApp
//
//  Created by Patrick Hayes on 11/17/17.
//  Copyright © 2017 Patrick Hayes. All rights reserved.
//

import UIKit

protocol AddBookDelegate: class {
    
    func bookSaved(by controller: AddAuthorViewController, with text: String, at indexPath: NSIndexPath?)
    func cancelButtonPressed(by controller: AddAuthorViewController)
    
}
