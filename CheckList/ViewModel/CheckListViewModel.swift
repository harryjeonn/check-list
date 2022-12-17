//
//  CheckListViewModel.swift
//  CheckList
//
//  Created by 전현성 on 2022/12/15.
//

import Foundation
import RxSwift
import RxCocoa

class CheckListViewModel: ViewModel {
    var disposeBag: DisposeBag = DisposeBag()
    
    let checkListItems: BehaviorRelay<[String]> = BehaviorRelay<[String]>(value: [
        "인덕션",
        "고데기",
        "불 끄기",
        "드라이기"
    ])
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}
