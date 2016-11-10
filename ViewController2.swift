//
//  ViewController2.swift
//  joelfleuren-pset2
//
//  Created by joel fleuren on 08-11-16.
//  Copyright © 2016 joel fleuren. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var wordslabel: UILabel!
    @IBOutlet weak var inputfield: UITextField!
    @IBOutlet weak var submit: UIButton!
    
    var story: Story!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.path(forResource: "madlib0_simple", ofType: "txt") {
            do {
                let content = try String(contentsOfFile: path)
                story = Story(stream: content)
                wordslabel.text = "\(story.getPlaceholderCount()) word(s) left"
                inputfield.placeholder = story.getNextPlaceholder()
            } catch {
                print("Failed to read content of TextFile")
            }
        } else {
            print("Couldn't find the selected TextFile")
        }
    }
    
    @IBAction func buttonClicked(button: UIButton) {
        
        if ((inputfield.text?.characters.count)! > 0) {
            
            story.fillInPlaceholder(word: inputfield.text!)
            inputfield.placeholder = story.getNextPlaceholder()
            
            if (story.isFilledIn()) {
                performSegue(withIdentifier: "segueID", sender: story.toString())
                story.clear()
                
                
                if let path = Bundle.main.path(forResource: "madlib0_simple", ofType: "txt") {
                    do {
                        let content = try String(contentsOfFile: path)
                        story = Story(stream: content)
                        wordslabel.text = "\(story.getPlaceholderCount()) word(s) left"
                        inputfield.placeholder = story.getNextPlaceholder()
                    } catch {
                        print("Failed to read content of TextFile")
                    }
                } else {
                    print("Couldn't find the selected TextFile")
                }

                
            }
            
            wordslabel.text = "\(story.getPlaceholderRemainingCount()) word(s) left"
            inputfield.text = ""
            
        } else {
            
            print("Please inset a text!")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueID") {
            let madLibText = sender as! String
            let destinationVC = segue.destination as! ViewController3
            destinationVC.madLibText = madLibText
        }
    }
    
    
    
    
    
    
    
    
    
    

}
