//
//  SharedTestHelpers.swift
//  EssentialAppTests
//
//  Created by Lev Litvak on 25.08.2022.
//  Copyright © 2022 Essential Developer. All rights reserved.
//

import Foundation

func anyNSError() -> NSError {
     return NSError(domain: "any error", code: 0)
 }

 func anyURL() -> URL {
     return URL(string: "http://any-url.com")!
 }

 func anyData() -> Data {
     return Data("any data".utf8)
 }
