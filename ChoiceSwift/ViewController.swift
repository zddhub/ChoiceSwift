//
//  ViewController.swift
//  ChoiceSwift
//
//  Created by zdd on 12/28/14.
//  Copyright (c) 2014 zdd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var isA: Bool = true

    var width: CGFloat = UIScreen.mainScreen().bounds.size.width
    var height: CGFloat = UIScreen.mainScreen().bounds.size.height

    var choiceRect:CGRect!

    var timer: NSTimer?
    var timerStarted = false
    var count = 0
    var randomNum = 0

    let choiceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"Helvetica", size: UIScreen.mainScreen().bounds.size.height*0.4)
        label.textAlignment = NSTextAlignment.Center
        return label
        }()

    let choiceButton: UIButton = {
        let button = UIButton()
        return button
        }()

    func setLabelText() {
        if self.isA {
            choiceLabel.text = "A"
        } else {
            choiceLabel.text = "B"
        }
    }

    func updateChoice() {
        if timerStarted && count < randomNum {
            isA = !isA
            setLabelText()
            count += 1
        } else {
            count = 0
            randomNum = 0
            timerStarted = false

            if let t = timer {
                t.invalidate()
            }
            timer = nil
        }
    }

    func choose() {
        if (!timerStarted) {
            randomNum = randomInRange(15...18)
            timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: "updateChoice", userInfo: nil, repeats: true)
            timerStarted = true
        }
    }

    // Produce random
    func randomInRange(range: Range<Int>) -> Int {
        let count = UInt32(range.endIndex - range.startIndex)
        return  Int(arc4random_uniform(count)) + range.startIndex
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        choiceRect = CGRectMake(width/2 - height*0.2, height*0.1, height*0.4, height*0.4)

        choiceLabel.frame = choiceRect

        // First time
        for _ in 0...randomInRange(15...18) {
            isA = !isA
        }
        setLabelText()
        self.view.addSubview(choiceLabel)

        choiceButton.frame = choiceRect
        choiceButton.addTarget(self, action: "choose", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(choiceButton)

        let bestChoiceLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name:"Helvetica", size: UIScreen.mainScreen().bounds.size.width*0.08)
            label.textAlignment = NSTextAlignment.Center
            label.textColor = UIColor.lightGrayColor()
            return label
            }()
        let rect = CGRectMake(width*0.1, height*0.5, width*0.8, height*0.2)
        bestChoiceLabel.frame = rect
        bestChoiceLabel.text = "BEST CHOICE"
        self.view.addSubview(bestChoiceLabel)

        let holdonLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name:"Helvetica", size: UIScreen.mainScreen().bounds.size.width*0.08)
            label.textAlignment = NSTextAlignment.Center
            label.textColor = UIColor.lightGrayColor()
            return label
            }()
        let hRect = CGRectMake(width*0.1, height*0.6, width*0.8, height*0.2)
        holdonLabel.frame = hRect
        holdonLabel.text = "PLEASE HOLD ON"
        self.view.addSubview(holdonLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

