//
//  ViewController3.swift
//  joelfleuren-pset2
//
//  Created by joel fleuren on 08-11-16.
//  Copyright © 2016 joel fleuren. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {
    
    var madLibText = ""
    
    @IBOutlet weak var storytext: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storytext.text = madLibText
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
