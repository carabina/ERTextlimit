//
//  ViewController.swift
//  ERTextlimit
//
//  Created by earlred on 11/22/2017.
//  Copyright (c) 2017 earlred. All rights reserved.
//

import UIKit
import ERTextlimit


class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.textField.showCharactersLeft(maxChars: 30)
        self.textView.showCharactersLeft(maxChars: 50)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

