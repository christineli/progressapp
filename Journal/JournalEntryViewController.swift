/*

This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike
4.0 International License, by Yong Bakos.

*/

import UIKit
import Firebase


class JournalEntryViewController: UIViewController {
    
    @IBOutlet weak var journalEntryContents: UITextView!
    var journalEntry: JournalEntry?
    var index: Int?
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var energyLevelLabel: UILabel!
    @IBOutlet weak var happinessLevelLabel: UILabel!
    @IBOutlet weak var anxietyLevelLabel: UILabel!
    
    let editJournalEntrySegueIdentifier = "editJournalEntry"
    let emotionDetailSegueIdentifier = "emotionDetail"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.journalEntryContents.layer.cornerRadius = 10
        self.journalEntryContents.layer.borderWidth = 3
        self.journalEntryContents.layer.borderColor = UIColor.white.cgColor
        self.journalEntryContents.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10)

        journalEntry?.ref.observe(.value, with: { snapshot in
            if (snapshot.exists()) {
                self.journalEntry = JournalEntry(snapshot: snapshot)
                self.journalEntryContents.text = self.journalEntry?.contents
                self.energyLevelLabel.text = self.journalEntry?.energyLevel.description
                self.happinessLevelLabel.text = self.journalEntry?.happinessLevel.description
                self.anxietyLevelLabel.text = self.journalEntry?.anxietyLevel.description
                self.navigationItem.title = self.journalEntry?.description
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == editJournalEntrySegueIdentifier {
            let editJournalEntryViewController = segue.destination as? EditJournalEntryViewController
            editJournalEntryViewController?.journalEntry = journalEntry
            editJournalEntryViewController?.index = index
        } else if segue.identifier == emotionDetailSegueIdentifier {
            let journalEntryEmotionViewController = segue.destination as? JournalEntryEmotionViewController
            journalEntryEmotionViewController?.journalEntry = journalEntry
        }
    }
}
