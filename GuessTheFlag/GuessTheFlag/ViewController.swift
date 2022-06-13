//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Marc Moxey on 5/16/22.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet var buttonOne: UIButton!
    @IBOutlet var buttonTwo: UIButton!
    @IBOutlet var buttonThree: UIButton!
    
    var countries = [String] ()
    var score = 0
    var correctAnswer = 0
    var numQuestion = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        buttonOne.layer.borderWidth = 1
        buttonTwo.layer.borderWidth = 1
        buttonThree.layer.borderWidth = 1
        
        buttonOne.layer.borderColor = UIColor.lightGray.cgColor
        buttonTwo.layer.borderColor = UIColor.lightGray.cgColor
        buttonThree.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showScore))
    }

    func askQuestion(action: UIAlertAction! = nil) {
        
        countries.shuffle()
        
        correctAnswer = Int.random(in: 0...2)
        //assign image to button, standard state of button is change
        buttonOne.setImage(UIImage(named: countries[0]), for: .normal)
        buttonTwo.setImage(UIImage(named: countries[1]), for: .normal)
        buttonThree.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased() + ", " + "Score: \(score)"
    }
    
    
    @IBAction func ButtonTapped(_ sender: UIButton) {
        var title: String
        var msg: String
    
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            msg = "Your score is \(score)"
           
        } else {
            title = "Wrong"
            msg = "Wrong! That's the flag of \(countries[sender.tag])"
            if score > 0 {
                score -= 1
            }
        }
        
        numQuestion += 1
        
        
        if numQuestion < 10 {
            //bring message box to center of screen
            var ac = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            
            //add button to alert that say "Continue", handler looks for code to execute
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
           
            //view controller to present, plays animation
            present(ac, animated: true)
        } else {
           var  ac = UIAlertController(title: "Game Over", message: "Your Final Score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Play again", style: .default, handler: askQuestion))
            present(ac, animated: true)
            score = 0
            
        }
      
    }
    
    
    @objc func showScore() {
        let scoreSum  =  "\(score)"
         
        let vc = UIActivityViewController(activityItems: [scoreSum], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
        
    }
    

}

