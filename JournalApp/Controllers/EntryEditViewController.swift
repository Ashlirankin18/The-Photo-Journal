//
//  EntryEditViewController.swift
//  JournalApp
//
//  Created by Ashli Rankin on 1/16/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class EntryEditViewController: UIViewController {
  private var imagePickerController: UIImagePickerController!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  
  @IBOutlet weak var titleTextField: UITextView!
  
  @IBOutlet weak var entryImage: UIImageView!
  
  @IBOutlet weak var cameraButton: UIBarButtonItem!
  
  @IBOutlet weak var navBar: UINavigationItem!
  var entry: JournalEntry!
  var currentIndex = 0
  var isBeingEdited = Bool()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      setupImagePickerController()
      isThereAnEntry()
    }
 
  private func setupImagePickerController(){
    imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    if !UIImagePickerController.isSourceTypeAvailable(.camera
      ){
      cameraButton.isEnabled = false
    }
  }
  func isThereAnEntry(){
    if let entry = entry {
      isBeingEdited = true
      saveButton.isEnabled = true
      self.entryImage.image = UIImage(data: entry.image)
      self.titleTextField.text = entry.description
    } else{
      saveButton.isEnabled = false
    }
    
  }
  private func showImagePickerController(){
    self.present(imagePickerController, animated: true, completion: nil)
  }
  @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
    if isBeingEdited {
      let entry = JournalEntry.init(createdAt: "i dont know", description: titleTextField.text, image: uiImageToDaTa(image: self.entryImage.image!)!)
      PersistanceHelper.updateTheDirectory(entry: entry, index: currentIndex)
    } else {
    if let text = titleTextField.text {
      let entry = JournalEntry.init(createdAt: "i dont know yet", description: text, image: uiImageToDaTa(image: self.entryImage.image!)!)
        PersistanceHelper.addFilesToDirectory(entry: entry)
      }
    }

    dismiss(animated: true, completion: nil)
    
  }
  
  func uiImageToDaTa(image:UIImage) -> Data?{
    let imageData = image.jpegData(compressionQuality: 0.5)
    return imageData
  }
  
  @IBAction func photoLibraryButtonPressed(_ sender: UIBarButtonItem) {
    showImagePickerController()
  }
}

extension EntryEditViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
      entryImage.image = image
      saveButton.isEnabled = true
    }
    dismiss(animated: true, completion: nil)
  }
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
}


