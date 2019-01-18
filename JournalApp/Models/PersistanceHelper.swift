//
//  PersistanceHelper.swift
//  JournalApp
//
//  Created by Ashli Rankin on 1/16/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import Foundation
final class PersistanceHelper {
  private static let filename = "Journal.plist"
  private static var entries = [JournalEntry]()
  static func saveFilesToDirectory(){
    let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename)
    do{
      let data = try PropertyListEncoder().encode(entries)
      try data.write(to: path, options: Data.WritingOptions.atomic)
    } catch{
      print("Property list encoding error")
    }
  }
  
  static func getEntries() -> [JournalEntry]{
    let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename).path
    if FileManager.default.fileExists(atPath: path) {
      if let data = FileManager.default.contents(atPath: path){
        do {
          entries = try PropertyListDecoder().decode([JournalEntry].self, from: data)
          
        } catch {
          print("No entries found")
        }
      }
    } else {
      print("\(filename) does not exist")
    }
    return entries
  }
  static func addFilesToDirectory(entry:JournalEntry){
    entries.append(entry)
    saveFilesToDirectory()
  }
  static func deleteItemsFromArray(index:Int){
    entries.remove(at: index)
    saveFilesToDirectory()
  }
  static func updateTheDirectory(entry:JournalEntry,index:Int){
    entries.insert(entry, at: index)
    saveFilesToDirectory()
  }
}
