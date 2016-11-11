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
    // Array with stories
    let stories = ["madlib0_simple",
                   "madlib1_tarzan",
                   "madlib2_university",
                   "madlib3_clothes",
                   "madlib4_dance"
                   ]
    // initialized random variabel
    var randomIndex:Int!
    // initialize Story
    var story: Story!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StoryText()
    }
    private func StoryText(){
        // choose a random story form the array
        let randomIndex = Int(arc4random_uniform(UInt32(stories.count)))
        // check if the path of the stories is correct
        if let path = Bundle.main.path(forResource: stories[randomIndex], ofType: "txt") {
            do {
                // set content to a string of the file
                let content = try String(contentsOfFile: path)
                story = Story(stream: content)
                // place the remainder of the words loeft in the label
                wordslabel.text = "\(story.getPlaceholderCount()) word(s) left"
                // set the next place holder in the inputfield
                inputfield.placeholder = story.getNextPlaceholder()
            } catch {
                print("Failed to read content of TextFile")
            }
        } else {
            print("Couldn't find the selected TextFile")
        }
    }
    
    @IBAction func buttonClicked(button: UIButton) {
        // check if there are characters entered in the inputfield
        if ((inputfield.text?.characters.count)! > 0) {
            // fill the entered word in the text
            story.fillInPlaceholder(word: inputfield.text!)
            // go to the next placeholder
            inputfield.placeholder = story.getNextPlaceholder()
            // check if the story is filled in
            if (story.isFilledIn()) {
                // segue the story to viewController 3
                performSegue(withIdentifier: "segueID", sender: story.toString())
                story.clear()
                StoryText()
            }
            // update the remaing words left to fill in by the user
            wordslabel.text = "\(story.getPlaceholderRemainingCount()) word(s) left"
            // clear inputfield
            inputfield.text = ""
            
        } else {
            
            print("Please inset a text!")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // prepare to send dat to the next viewcontroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueID") {
            let madLibText = sender as! String
            // set the destination of the segue
            let ToTheNextVC = segue.destination as! ViewController3
            ToTheNextVC.madLibText = madLibText
        }
    }
    
    
    
    
    
    
    
    
    
    

}
