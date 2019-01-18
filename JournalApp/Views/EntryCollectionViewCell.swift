//
//  EntryCollectionViewCell.swift
//  JournalApp
//
//  Created by Ashli Rankin on 1/16/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class EntryCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var entryImage: UIImageView!
  @IBOutlet weak var entryTitle: UILabel!
  @IBOutlet weak var expandButton: UIButton!
  
  
  public func configureCell(entry: JournalEntry) {
    entryImage.image = UIImage.init(data: entry.image)
    entryTitle.text = entry.description
  }
  
}
