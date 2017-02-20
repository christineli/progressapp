/*

This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike
4.0 International License, by Yong Bakos.

*/

import UIKit
import Firebase

class JournalTableViewController: UITableViewController {

    let cellReuseIdentifier = "JournalEntryCell"
    let journalEntrySegueIdentifier = "journalEntry"
    let newJournalEntrySegueIdentifier = "newJournalEntry"
    let viewStatsSegueIdentifier = "viewStats"
    
    var ref : FIRDatabaseReference!
    let usersRef = FIRDatabase.database().reference(withPath: "online")
    var user: User!
    
    var journal = Journal()
    var entries: [JournalEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference(withPath: "journalEntries")
        ref.queryOrdered(byChild: "date").observe(.value, with: { snapshot in
            var newEntries: [JournalEntry] = []
            
            for item in snapshot.children {
                let entry = JournalEntry(snapshot: item as! FIRDataSnapshot)
                if (entry.addedByUser == FIRAuth.auth()?.currentUser?.uid) {
                    newEntries.insert(entry, at: 0)
                }
            }
            self.entries = newEntries
            let range = NSMakeRange(0, self.tableView.numberOfSections)
            let sections = NSIndexSet(indexesIn: range)
            self.tableView.reloadSections(sections as IndexSet, with: .automatic)        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let range = NSMakeRange(0, self.tableView.numberOfSections)
        let sections = NSIndexSet(indexesIn: range)
        self.tableView.reloadSections(sections as IndexSet, with: .automatic)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) 
        let label = cell.textLabel
        let entry = entries[((indexPath as NSIndexPath).row)]
//        label?.text = String(describing: entry.date)
        label?.text = entry.contents
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entry = entries[indexPath.row]
            entry.ref.removeValue()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == journalEntrySegueIdentifier {
            let journalEntryViewController = segue.destination as? JournalEntryViewController
            let cell = sender as? UITableViewCell
            let indexPath = self.tableView.indexPath(for: cell!)
            let entry = entries[(indexPath?.row)!]
            journalEntryViewController?.journalEntry = entry
            journalEntryViewController?.index = (indexPath?.row)!
        } else if segue.identifier == newJournalEntrySegueIdentifier {
            let newJournalEntryViewController = segue.destination as? NewJournalEntryViewController
            newJournalEntryViewController?.journal = journal
        } else if segue.identifier == viewStatsSegueIdentifier {
            let statsViewController = segue.destination as? StatsViewController
            statsViewController?.journal = journal

        }
    }

}
