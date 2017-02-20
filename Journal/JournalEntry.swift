/*

This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike
4.0 International License, by Yong Bakos.

*/

import Foundation
import Firebase

class JournalEntry: CustomStringConvertible {
    //Properties
    let date: Date
    let contents: String
    let happinessLevel: Int
    let energyLevel: Int
    let anxietyLevel: Int
    var ref = FIRDatabase.database().reference()
    let addedByUser: String
    var anger_score: Double?
    var disgust_score: Double?
    var fear_score: Double?
    var joy_score: Double?
    var sadness_score: Double?
    var analytical_score: Double?
    var confindent_score: Double?
    var tentative_score: Double?
    var openess_score: Double?
    var conscientiousness_score: Double?
    var extraversion_score: Double?
    var agreeableness_score: Double?
    var emotional_range_score: Double?
    let dateFormatter = DateFormatter()
    var description: String {
        return dateFormatter.string(from: date)
    }
    
    init(date: Date,
         contents: String,
         happinessLevel: Int,
         energyLevel: Int,
         anxietyLevel: Int,
         addedByUser: String,
         anger_score: Double,
         disgust_score: Double,
         fear_score: Double,
         joy_score: Double,
         sadness_score: Double,
         analytical_score: Double,
         confindent_score: Double,
         tentative_score: Double,
         openess_score: Double,
         conscientiousness_score: Double,
         extraversion_score: Double,
         agreeableness_score: Double,
         emotional_range_score: Double) {
            self.date = date
            self.contents = contents
            self.happinessLevel = happinessLevel
            self.energyLevel = energyLevel
            self.anxietyLevel = anxietyLevel
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            self.addedByUser = addedByUser
            self.anger_score = anger_score
            self.disgust_score = disgust_score
            self.fear_score = fear_score
            self.joy_score = joy_score
            self.sadness_score = sadness_score
            self.analytical_score = analytical_score
            self.confindent_score = confindent_score
            self.tentative_score = tentative_score
            self.openess_score = openess_score
            self.conscientiousness_score = conscientiousness_score
            self.extraversion_score = extraversion_score
            self.agreeableness_score = agreeableness_score
            self.emotional_range_score = emotional_range_score
    }
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.date = Date(timeIntervalSince1970: snapshotValue["date"] as! TimeInterval)
        self.contents = snapshotValue["contents"] as! String
        self.happinessLevel = snapshotValue["happinessLevel"] as! Int
        self.energyLevel = snapshotValue["energyLevel"] as! Int
        self.anxietyLevel = snapshotValue["anxietyLevel"] as! Int
        self.addedByUser = snapshotValue["addedByUser"] as! String
        if ((snapshotValue["anger_score"]) != nil) {
            self.anger_score = snapshotValue["anger_score"] as? Double
            self.disgust_score = snapshotValue["disgust_score"] as? Double
            self.fear_score = snapshotValue["fear_score"] as? Double
            self.joy_score = snapshotValue["joy_score"] as? Double
            self.sadness_score = snapshotValue["sadness_score"] as? Double
            self.analytical_score = snapshotValue["analytical_score"] as? Double
            self.confindent_score = snapshotValue["confindent_score"] as? Double
            self.tentative_score = snapshotValue["tentative_score"] as? Double
            self.openess_score = snapshotValue["openess_score"] as? Double
            self.conscientiousness_score = snapshotValue["conscientiousness_score"] as? Double
            self.extraversion_score = snapshotValue["extraversion_score"] as? Double
            self.agreeableness_score = snapshotValue["agreeableness_score"] as? Double
            self.emotional_range_score = snapshotValue["emotional_range_score"] as? Double
        }
        ref = snapshot.ref
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
    }
    func toDictionary() -> NSDictionary{
        return [
            "date": date.timeIntervalSince1970,
            "contents": contents,
            "happinessLevel": happinessLevel,
            "energyLevel": energyLevel,
            "anxietyLevel": anxietyLevel,
            "addedByUser": addedByUser,
            "anger_score": anger_score!,
            "disgust_score": disgust_score!,
            "fear_score": fear_score!,
            "joy_score" : joy_score!,
            "sadness_score": sadness_score!,
            "analytical_score": analytical_score!,
            "confindent_score": confindent_score!,
            "tentative_score": tentative_score!,
            "openess_score": openess_score!,
            "conscientiousness_score": conscientiousness_score!,
            "extraversion_score": extraversion_score!,
            "agreeableness_score": agreeableness_score!,
            "emotional_range_score": emotional_range_score!
        ]
    }
    func getDate() -> NSArray{
        let cal = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let components = (cal?.components([.day, .month, .year], from: date))!
        let day = components.day!
        let month = components.month!
        let year = components.year!

        return[day, month, year]
    }
    
    
}
