//
//  ProfileViewController.swift
//  Journal
//
//  Created by Jonah May on 2/12/17.
//  Copyright © 2017 Your School. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    // MARK: Constants
    let viewReminderSettings = "viewReminderSettings"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func logoutButtonPressed(_ sender: Any) {
        do {
            try FIRAuth.auth()!.signOut()
            dismiss(animated: true, completion: nil)
        } catch {
        }
    }
}
