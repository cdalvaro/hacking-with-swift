//
//  ActionViewController.swift
//  Extension
//
//  Created by Carlos Álvaro on 28/7/22.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class ActionViewController: UIViewController {
    @IBOutlet weak var script: UITextView!
    
    var pageTitle = ""
    var pageURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        
        /**
         It might sound like we don't need `keyboardWillHideNotification`
         if we have `keyboardWillChangeFrameNotification`, but in my testing just using
         `keyboardWillChangeFrameNotification` isn't enough to catch a hardware keyboard
         being connected. Now, that's an extremely rare case, but we might as well be sure!
         */
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first {
                itemProvider.loadItem(forTypeIdentifier: UTType.propertyList.identifier) { [weak self] (dict, error) in
                    guard let itemDictionary = dict as? NSDictionary else { return }
                    guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
                    
                    self?.pageTitle = javaScriptValues["title"] as? String ?? ""
                    self?.pageURL = javaScriptValues["URL"] as? String ?? ""
                    
                    DispatchQueue.main.async {
                        self?.title = self?.pageTitle
                        
                    }
                }
            }
        }
    }

    @IBAction func done() {
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": script.text ?? ""]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: UTType.propertyList.identifier)
        item.attachments = [customJavaScript]
        
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        extensionContext?.completeRequest(returningItems: [item])
    }
    
    @objc func adjustForKeyboard(notificacion: Notification) {
        /**
         First, it will receive a parameter that is of type `Notification`.
         This will include the name of the notification as well as a `Dictionary`
         containing notification-specific information called `userInfo`.
         */
        guard let keyboardValue = notificacion.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        /**
         When working with keyboards, the dictionary will contain a key called
         `UIResponder.keyboardFrameEndUserInfoKey` telling us the frame
         of the keyboard after it has finished animating.
         
         Once we finally pull out the correct frame of the keyboard,
         we need to convert the rectangle to our view's co-ordinates.
         This is because rotation isn't factored into the frame, so if the user is in landscape
         we'll have the width and height flipped – using the convert() method will fix that.
         */
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        /**
         The next thing we need to do in the `adjustForKeyboard()` method
         is to adjust the contentInset and scrollIndicatorInsets of our text view.
         These two essentially indent the edges of our text view so that it appears to occupy
         less space even though its constraints are still edge to edge in the view.
         */
        if notificacion.name == UIResponder.keyboardWillHideNotification {
            script.contentInset = .zero
        } else {
            script.contentInset = UIEdgeInsets(top: 0,
                                               left: 0,
                                               bottom: keyboardScreenEndFrame.height - view.safeAreaInsets.bottom,
                                               right: 0)
        }
        
        script.scrollIndicatorInsets = script.contentInset
        
        /**
         Finally, we're going to make the text view scroll so that the text entry cursor is visible.
         If the text view has shrunk this will now be off screen,
         so scrolling to find it again keeps the user experience intact.
         */
        let selectedRange = script.selectedRange
        script.scrollRangeToVisible(selectedRange)
    }

}
