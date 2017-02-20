//
//  EditJournalEntryViewController.swift
//  Journal
//
//  Created by Christine Li on 11/13/16.
//  Copyright © 2016 Your School. All rights reserved.
//
import UIKit
import Firebase
import ToneAnalyzerV3

class EditJournalEntryViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var journalEntryContents: UITextView!
    
    @IBOutlet weak var energyRatingControl: RatingControl!
    @IBOutlet weak var happinessRatingControl: RatingControl!
    @IBOutlet weak var anxietyRatingControl: RatingControl!
    
    
    var journal: Journal?
    var journalEntry: JournalEntry?
    var index: Int?
    let ref = FIRDatabase.database().reference(withPath: "journalEntries")
    let usersRef = FIRDatabase.database().reference(withPath: "online")
    var user: User!
    
    override func viewWillAppear(_ animated: Bool) {
        journalEntryContents.text = journalEntry?.contents
        if let journalEntry = journalEntry {
            journalEntryContents.text = journalEntry.contents
            energyRatingControl.rating = journalEntry.energyLevel
            happinessRatingControl.rating = journalEntry.happinessLevel
            anxietyRatingControl.rating = journalEntry.anxietyLevel
            navigationItem.title = journalEntry.description
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        journalEntryContents.delegate = self
        self.journalEntryContents.layer.cornerRadius = 10
        self.journalEntryContents.layer.borderWidth = 1
        self.journalEntryContents.layer.borderColor = UIColor.black.cgColor
        self.automaticallyAdjustsScrollViewInsets = false
        FIRAuth.auth()!.addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = User(authData: user)
            let currentUserRef = self.usersRef.child(self.user.uid)
            currentUserRef.setValue(self.user.email)
            currentUserRef.onDisconnectRemoveValue()
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        let username = "5da3aac4-a197-4d0b-862d-ef2dbcd798ae"
        let password = "hpKKnrY7ByGx"
        let version = "2017-02-14"
        let toneAnalyzer = ToneAnalyzer(username: username, password: password, version: version)
        let text = journalEntryContents.text
        var anger_score = 0.0
        var disgust_score = 0.0
        var fear_score = 0.0
        var joy_score = 0.0
        var sadness_score = 0.0
        var analytical_score = 0.0
        var confindent_score = 0.0
        var tentative_score = 0.0
        var openess_score = 0.0
        var conscientiousness_score = 0.0
        var extraversion_score = 0.0
        var agreeableness_score = 0.0
        var emotional_range_score = 0.0
        let failure = { (error: Error) in print(error) }
        toneAnalyzer.getTone(ofText: text!, failure: failure) { tones in
            anger_score = tones.documentTone[0].tones[0].score
            disgust_score = tones.documentTone[0].tones[1].score
            fear_score = tones.documentTone[0].tones[2].score
            joy_score = tones.documentTone[0].tones[3].score
            sadness_score = tones.documentTone[0].tones[4].score
            analytical_score = tones.documentTone[1].tones[0].score
            confindent_score = tones.documentTone[1].tones[1].score
            tentative_score = tones.documentTone[1].tones[2].score
            openess_score = tones.documentTone[2].tones[0].score
            conscientiousness_score = tones.documentTone[2].tones[1].score
            extraversion_score = tones.documentTone[2].tones[2].score
            agreeableness_score = tones.documentTone[2].tones[3].score
            emotional_range_score = tones.documentTone[2].tones[4].score
            let entry = JournalEntry(date: (self.journalEntry?.date)!,
                                     contents: self.journalEntryContents.text,
                                     happinessLevel: self.happinessRatingControl.rating,
                                     energyLevel: self.energyRatingControl.rating,
                                     anxietyLevel: self.anxietyRatingControl.rating,
                                     addedByUser: self.user.uid,
                                     anger_score: anger_score,
                                     disgust_score: disgust_score,
                                     fear_score: fear_score,
                                     joy_score: joy_score,
                                     sadness_score: sadness_score,
                                     analytical_score: analytical_score,
                                     confindent_score: confindent_score,
                                     tentative_score: tentative_score,
                                     openess_score: openess_score,
                                     conscientiousness_score: conscientiousness_score,
                                     extraversion_score: extraversion_score,
                                     agreeableness_score: agreeableness_score,
                                     emotional_range_score: emotional_range_score)
            
            let entryRef = self.journalEntry?.ref
            entryRef?.setValue(entry.toDictionary())
        }
        

        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func userTappedBackground(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    //MARK: UITextViewDelegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Record your thoughts!"
            textView.textColor = UIColor.lightGray
        }
    }
    
    
    
}
