//
//  MainViewModel.swift
//  CheckList
//
//  Created by 전현성 on 2022/12/15.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel {
    var title = PublishSubject<String>()
    
    func changeTitle() {
        title.onNext("after")
    }
}
