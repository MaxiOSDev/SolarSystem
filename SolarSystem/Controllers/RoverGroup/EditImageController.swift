//
//  EditImageController.swift
//  SolarSystem
//
//  Created by Max Ramirez on 5/4/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit
import Nuke
import JLStickerTextView
import MessageUI

class EditImageController: UIViewController {
    
    // @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageView: JLStickerImageView!
    
    var photo: Photo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = ImageRequest(url: URL(string: (photo?.imgSrc)!)!)
        Nuke.loadImage(with: request, into: imageView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addTextField(_ sender: UIButton) {
        imageView.addLabel()
        imageView.textColor = .blue
        imageView.textAlpha = 1
        
    }
    
    @IBAction func saveImage(_ sender: UIButton) {
//        if let imageAttachment = imageView.renderTextOnView(imageView) {
//            UIImageWriteToSavedPhotosAlbum(imageAttachment, nil, nil, nil)
//        }
        
        if let imageAttachment = imageView.renderContentOnView() {
            UIImageWriteToSavedPhotosAlbum(imageAttachment, nil, nil, nil)
        }
        
        
    }
    
    @IBAction func sendImage(_ sender: UIBarButtonItem) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    // MARK: - Helper Methods
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["reviewerEmail@teamtreehouse.com"])
        mailComposerVC.setSubject("Sending you an in-app e-mail...")
        mailComposerVC.setMessageBody("Sending e-mail in-app is not so bad!", isHTML: false)
//        if let image = imageView.renderTextOnView(imageView) {
//            if let imageData = UIImageJPEGRepresentation(image, 1.0) {
//                mailComposerVC.addAttachmentData(imageData, mimeType: "image/jpeg", fileName: "\(photo.earthDate).jpg")
//            }
//        }

        if let image = imageView.renderContentOnView() {
            
//            if let imageData = UIImageJPEGRepresentation(image, 1.0) {
//                mailComposerVC.addAttachmentData(imageData, mimeType: "image/jpeg", fileName: "\(photo.earthDate).jpg")
//            }
            
            if let imageData = image.jpegData(compressionQuality: 0.75) {
                mailComposerVC.addAttachmentData(imageData, mimeType: "image/jpeg", fileName: "\(photo.earthDate).jpg")
            }
  
        }
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let alert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail. Please check e-mail configuration and try again", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension EditImageController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
}
