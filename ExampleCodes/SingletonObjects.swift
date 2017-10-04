//
//  SingletonObjects.swift
//  ExampleCodes
//
//  Created by boqian cheng on 2017-10-03.
//  Copyright © 2017 boqiancheng. All rights reserved.
//

import Foundation
import UIKit
import Moya
import Alamofire
import RxSwift
import UserNotifications

let netWorkProvider = RxMoyaProvider<LibAPI>()
let disposeBag = DisposeBag()
let center = UNUserNotificationCenter.current()

