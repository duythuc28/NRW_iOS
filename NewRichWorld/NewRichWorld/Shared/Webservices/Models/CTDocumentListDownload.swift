//
//  CTDocumentListDownload.swift
//  Chantier
//
//  Created by Mobile03 on 9/21/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation

class CTDocumentListDownload {
  private var documentListDownload = [CTDocumentDownload]()
  class var shareInstance: CTDocumentListDownload {
    struct Singleton {
      static let instance = CTDocumentListDownload()
    }
    return Singleton.instance
  }

  init() {
    
  }
  
  func getDocumentListDownload() -> [CTDocumentDownload] {
    return self.documentListDownload
  }
  
  func addDocumentDownload(remoteId: Int) {
    let documentDownload = CTDocumentDownload()
    documentDownload.remoteId = remoteId
    documentDownload.isDownload = true
    self.documentListDownload.append(documentDownload)
  }
  
  func removeDocumentDownload(remoteId: Int) {
    for documentDownload in self.documentListDownload {
      if documentDownload.remoteId == remoteId {
        let index = self.documentListDownload.indexOf{$0 === documentDownload}
        self.documentListDownload.removeAtIndex(index!)
        break
      }
    }
  }
  
  func updateDocumentDownloading(remoteId: Int) {
    for documentDownload in self.documentListDownload {
      if documentDownload.remoteId == remoteId {
        documentDownload.isDownload = true
        break
      }
    }
  }
  
  func isExist(remoteId: Int) -> Bool {
    for documentDownload in self.documentListDownload {
      if documentDownload.remoteId == remoteId {
        return true
      }
    }
    return false
  }
  
}

class CTDocumentDownload {
  var remoteId: Int?
  var isDownload: Bool = false
}