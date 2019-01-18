//
//  ViewController.swift
//  JournalApp
//
//  Created by Ashli Rankin on 1/16/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class EntryDisplayViewController: UIViewController {
//  let entryInstance = EntryHelper()
  @IBOutlet weak var entriesCollectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    entriesCollectionView.dataSource = self
    entriesCollectionView.delegate = self
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    entriesCollectionView.reloadData()
  }
  
  @IBAction func expandPressed(_ sender: UIButton) {
    let activitySheet = UIAlertController(title: "Options", message: "What would you like to do?", preferredStyle: .actionSheet)
    
    let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
      PersistanceHelper.deleteItemsFromArray(index: sender.tag)
        self.entriesCollectionView.reloadData()
    }
   
    let editAction = UIAlertAction(title: "Edit", style: .default) { (action) in

      let entry = PersistanceHelper.getEntries()[sender.tag]
     guard let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "entryController") as? EntryEditViewController else{return}
      viewController.currentIndex = sender.tag
      viewController.entry = entry
      viewController.isBeingEdited = true
      
      self.present(viewController, animated: true, completion: nil)
     
    
    }
    
    let shareAction = UIAlertAction(title: "Share", style: .default) { (action) in
      print("anything")
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
    
    }
    activitySheet.addAction(deleteAction)
    activitySheet.addAction(editAction)
    activitySheet.addAction(shareAction)
    activitySheet.addAction(cancelAction)
    
    self.present(activitySheet, animated: true, completion: nil)
  }
 
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    guard let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "entryController") as? EntryEditViewController else {return}
      viewController.isBeingEdited = false
    self.present(viewController, animated: true, completion: nil)
  
  }
}
extension EntryDisplayViewController:UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return PersistanceHelper.getEntries().count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = entriesCollectionView.dequeueReusableCell(withReuseIdentifier: "entryCell", for: indexPath) as? EntryCollectionViewCell else {fatalError()}
    
    let entry = PersistanceHelper.getEntries()[indexPath.row]
    cell.expandButton.tag = indexPath.row
    cell.configureCell(entry: entry)
    cell.layer.cornerRadius = 100
    
    return cell
  }
}

extension EntryDisplayViewController:UICollectionViewDelegateFlowLayout{
  override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
    return CGSize.init(width: 300, height: 350)
  }
}

