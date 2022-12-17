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
    
    struct Input {
        let tapTimeView: Observable<Void>
    }
    
    struct Output {
        let showSetTimeView: Observable<Void>
    }
    
    func transform(input: Input) -> Output {
        let tapTimeView = input.tapTimeView.asObservable()
        
        return Output(showSetTimeView: tapTimeView)
    }
}
