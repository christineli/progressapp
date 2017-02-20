//
//  JournalEntryEmotionViewController.swift
//  Journal
//
//  Created by Jonah May on 2/15/17.
//  Copyright © 2017 Your School. All rights reserved.
//

import UIKit

class JournalEntryEmotionViewController: UIViewController {
    var journalEntry: JournalEntry?

    @IBOutlet weak var angerLevelBar: UIProgressView!
    @IBOutlet weak var disgustLevelBar: UIProgressView!
    @IBOutlet weak var fearLevelBar: UIProgressView!
    @IBOutlet weak var joyLevelBar: UIProgressView!
    @IBOutlet weak var sadnessLevelBar: UIProgressView!
    @IBOutlet weak var analyticalLevelBar: UIProgressView!
    @IBOutlet weak var confidenceLevelBar: UIProgressView!
    @IBOutlet weak var tentativeLevelBar: UIProgressView!
    @IBOutlet weak var openessLevelBar: UIProgressView!
    @IBOutlet weak var conscientiousnessLevelBar: UIProgressView!
    @IBOutlet weak var extraversionLevelBar: UIProgressView!
    @IBOutlet weak var agreeablenessLevelBar: UIProgressView!
    @IBOutlet weak var emotionalRangeLevelBar: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        angerLevelBar.progress = Float((journalEntry?.anger_score)!)
        disgustLevelBar.progress = Float((journalEntry?.disgust_score)!)
        fearLevelBar.progress = Float((journalEntry?.fear_score)!)
        joyLevelBar.progress = Float((journalEntry?.joy_score)!)
        sadnessLevelBar.progress = Float((journalEntry?.sadness_score)!)
        analyticalLevelBar.progress = Float((journalEntry?.analytical_score)!)
        confidenceLevelBar.progress = Float((journalEntry?.confindent_score)!)
        tentativeLevelBar.progress = Float((journalEntry?.tentative_score)!)
        openessLevelBar.progress = Float((journalEntry?.openess_score)!)
        conscientiousnessLevelBar.progress = Float((journalEntry?.conscientiousness_score)!)
        extraversionLevelBar.progress = Float((journalEntry?.extraversion_score)!)
        agreeablenessLevelBar.progress = Float((journalEntry?.agreeableness_score)!)
        emotionalRangeLevelBar.progress = Float((journalEntry?.emotional_range_score)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
