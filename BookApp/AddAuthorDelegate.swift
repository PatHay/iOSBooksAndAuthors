//
//  AddAuthorDelegate.swift
//  BookApp
//
//  Created by Patrick Hayes on 11/16/17.
//  Copyright © 2017 Patrick Hayes. All rights reserved.
//

import UIKit

protocol AddAuthorDelegate: class {
    
    func authorSaved(by controller: AddAuthorViewController, with text: String, at indexPath: NSIndexPath?)
    func cancelButtonPressed(by controller: AddAuthorViewController)
    
}

