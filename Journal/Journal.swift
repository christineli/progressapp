/*

This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike
4.0 International License, by Yong Bakos.

*/

import Foundation

class Journal {
    
    fileprivate var entries: [JournalEntry] = []
    var count: Int {
        return entries.count
    }
    var totalEnergy: Int = 0
    var totalAnxiety: Int = 0
    var totalHappiness: Int = 0

    var averageEnergy: Float {
        return Float(totalEnergy) / Float(count)
    }
    var averageHappiness: Float {
        return Float(totalHappiness) / Float(count)
    }
    var averageAnxiety: Float {
        return Float(totalAnxiety) / Float(count)
    }
    func addEntry(_ entry: JournalEntry) {
        entries.append(entry)
        totalEnergy = totalEnergy + entry.energyLevel
        totalAnxiety = totalAnxiety + entry.anxietyLevel
        totalHappiness = totalHappiness + entry.happinessLevel
    }
    
    func editEntry(_ entry: JournalEntry, _ index: Int) {
        totalEnergy = totalEnergy - entries[index].energyLevel + entry.energyLevel
        totalAnxiety = totalAnxiety - entries[index].anxietyLevel + entry.anxietyLevel
        totalHappiness = totalHappiness - entries[index].happinessLevel + entry.happinessLevel
        entries[index]=entry
    }
    
    func entry(_ index: Int) -> JournalEntry? {
        if index >= 0 && index < count {
            return entries[index]
        } else {
            return nil
        }
    }
}
