//
//  NotificationService.swift
//  SmartechNSE
//
//  Created by Minal Pansare on 08/12/22.
//

import UserNotifications
import SmartPush
import UIKit

class NotificationService: UNNotificationServiceExtension {
  
  let smartechServiceExtension = SMTNotificationServiceExtension()
  
  override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
    //...
  if SmartPush.sharedInstance().isNotification(fromSmartech:request.content.userInfo){
      
      NSLog("SMT - NSE CALLED", request.content.userInfo)
      smartechServiceExtension.didReceive(request, withContentHandler: contentHandler)
    }
    //...
  }
  
  override func serviceExtensionTimeWillExpire() {
    //...
    smartechServiceExtension.serviceExtensionTimeWillExpire()
    //...
  }
}

//
//
//let AppboyAPNSDictionaryKey = "ab"
//let AppboyAPNSDictionaryAttachmentKey = "att"
//let AppboyAPNSDictionaryAttachmentURLKey = "url"
//let AppboyAPNSDictionaryAttachmentTypeKey = "type"
//
//class NotificationService: UNNotificationServiceExtension {
//  
//  var bestAttemptContent: UNMutableNotificationContent?
//  var contentHandler: ((UNNotificationContent) -> Void)?
//  var originalContent: UNMutableNotificationContent?
//  var abortOnAttachmentFailure: Bool = false
//  
//  override func didReceive(_ request: UNNotificationRequest, withContentHandler handler: @escaping (UNNotificationContent) -> Void) {
//    
//    contentHandler = handler
//    bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
//    originalContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
//      
//    print("[APPBOY] Push with mutable content received.")
//      
//    guard let appboyPayload = request.content.userInfo[AppboyAPNSDictionaryKey] as? [AnyHashable : Any] else { return displayOriginalContent("Push is not from Appboy.") }
//    
//    guard let attachmentPayload = appboyPayload[AppboyAPNSDictionaryAttachmentKey] as? [AnyHashable : Any] else { return displayOriginalContent("Push has no attachment.") }
//    
//    guard let attachmentURLString = attachmentPayload[AppboyAPNSDictionaryAttachmentURLKey] as? String else { return displayOriginalContent("Push has no attachment.") }
//    
//    guard let attachmentURL = URL(string: attachmentURLString) else { return displayOriginalContent("Cannot parse \(attachmentURLString) to URL.") }
//    
//    print("[APPBOY] Attachment URL string is \(attachmentURLString)")
//    
//    guard let attachmentType = attachmentPayload[AppboyAPNSDictionaryAttachmentTypeKey] as? String else { return displayOriginalContent("Push attachment has no type.") }
//    
//    print("[APPBOY] Attachment type is \(attachmentType)")
//    let fileSuffix: String = ".\(attachmentType)"
//    
//    // Download, store, and attach the content to the notification
//    let session = URLSession(configuration: URLSessionConfiguration.default)
//      
//    session.downloadTask(
//      with: attachmentURL,
//      completionHandler: { (temporaryFileLocation, response, error) in
//        
//      guard let temporaryFileLocation = temporaryFileLocation, error == nil else {
//        return self.displayOriginalContent("Error fetching attachment, displaying content unaltered: \(String(describing: error?.localizedDescription))")
//      }
//        
//      print("[Appboy] Data fetched from server, processing with temporary file url \(temporaryFileLocation.absoluteString)")
//        
//      let typedAttachmentURL = URL(fileURLWithPath:"\(temporaryFileLocation.path)\(fileSuffix)")
//        
//      do {
//        try FileManager.default.moveItem(at: temporaryFileLocation, to: typedAttachmentURL)
//      }
//      catch {
//        return self.displayOriginalContent("Failed to move file path.")
//      }
//        
//      guard let attachment = try? UNNotificationAttachment(identifier: "", url: typedAttachmentURL, options: nil) else { return self.displayOriginalContent("Attachment returned error.") }
//        
//      guard let bestAttemptContent = self.bestAttemptContent else { return self.displayOriginalContent("bestAttemptContent is nil") }
//        
//      bestAttemptContent.attachments = [attachment];
//      handler(bestAttemptContent);
//      }).resume()
//  }
//    
//  func displayOriginalContent(_ extraLogging: String) {
//    print("[APPBOY] \(extraLogging)")
//    print("[APPBOY] Displaying original content.")
//      
//    guard let contentHandler = contentHandler, let originalContent = originalContent else { return }
//    
//    contentHandler(originalContent)
//  }
//    
//  override func serviceExtensionTimeWillExpire() {
//    // Called just before the extension will be terminated by the system.
//    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
//    displayOriginalContent("Service extension called, displaying original content.")
//  }
//
//}
