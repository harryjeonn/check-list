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
        let addCheckList: Observable<String>
        let editCheckList: Observable<(String, Int)>
    }
    
    struct Output {
        let checkListItems: BehaviorRelay<[String]>
    }
    
    func transform(input: Input) -> Output {
        let checkListItems = BehaviorRelay<[String]>(value: [])
        
        input.addCheckList
            .subscribe(onNext: { checkList in
                var items = checkListItems.value
                items.append(checkList)
                checkListItems.accept(items)
            })
            .disposed(by: disposeBag)
        
        input.editCheckList
            .subscribe(onNext: { (str, index) in
                var newCheckListItems = checkListItems.value
                newCheckListItems[index] = str
                checkListItems.accept(newCheckListItems)
            })
            .disposed(by: disposeBag)
        
        return Output(checkListItems: checkListItems)
    }
}
