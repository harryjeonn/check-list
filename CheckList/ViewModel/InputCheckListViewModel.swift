//
//  InputCheckListViewModel.swift
//  CheckList
//
//  Created by 전현성 on 2022/12/27.
//

import Foundation
import RxSwift
import RxCocoa

class InputCheckListViewModel: ViewModel {
    var disposeBag: DisposeBag = DisposeBag()
    
    struct Input {
        let tapEnterButton: Observable<Void>
        let changeTextField: Observable<String>
    }
    
    struct Output {
        let checkList: Observable<String>
    }
    
    func transform(input: Input) -> Output {
        var text = ""
        
        let checkList = input.tapEnterButton
            .filter { text != "" }
            .map { _ in
                return text
            }
        
        input.changeTextField
            .subscribe(onNext: { str in
                text = str
            })
            .disposed(by: disposeBag)
        
        return Output(checkList: checkList)
    }
}
