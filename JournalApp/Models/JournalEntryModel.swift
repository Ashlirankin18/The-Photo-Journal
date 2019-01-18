//
//  JournalEntryModel.swift
//  JournalApp
//
//  Created by Ashli Rankin on 1/16/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import Foundation
struct JournalEntry:Codable{
  let createdAt:String
  let description:String
  let image: Data
}
