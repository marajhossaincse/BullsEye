//
//  ViewController.swift
//  BullsEye
//
//  Created by user on 11/29/21.
//  Copyright © 2021 marajhossaincse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // variable for slider's current value
    var currentValue: Int = 0
    
    // variable for random number to be guessed
    var targetValue: Int = 0
    
    var score = 0
    
    var round = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    // what the user views as soon as the view loader loads up
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let roundedValue = slider.value.rounded() // slider.value.rounded->rounded slider value
       
        currentValue = Int(roundedValue)
        
        targetValue = Int.random(in: 1...100)
        
        startNewGame()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }

    
    //Hit me function
    @IBAction func showHitMeAlert(){
        
        let difference = abs(targetValue - currentValue)
        
        var points = 100 - difference
        
        score += points
        
        let title: String
        
        if difference == 0{
            title = "Perfect!"
            points += 100
        } else if difference < 5{
            title = "You almost had it!"
            if difference == 1{
                points += 50
            }
        } else if difference < 10{
            title = "Pretty good"
        } else{
            title = "Not even close..."
        }
        
        
        //alert message loaded with current value
        let message = "You scored \(points) points"
        
        // alert action message
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
        
        // action after alert
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        // action "alert" being called
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    
    }
    
    // funtions if slider moved
    @IBAction func sliderMoved(_ slider: UISlider){
       
        let roundedValue = slider.value.rounded()                           //slider.value.rounded -> value in rounded form
        currentValue = Int(roundedValue)
    
    }
    
    @IBAction func startNewGame(){
        score = 0
        round = 0
        startNewRound()
    }
    
    // function for new round
    func startNewRound(){
        round += 1
        targetValue =  Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
        
    }
    
    // function for updating target label
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
}

