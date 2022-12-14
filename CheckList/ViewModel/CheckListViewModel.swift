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
        let removeCheckList: Observable<Int>
        let tapCheckBox: Observable<(Bool, Int)>
    }
    
    struct Output {
        let checkListItems: BehaviorRelay<[CheckListItem]>
    }
    
    func transform(input: Input) -> Output {
        let checkListItems = BehaviorRelay<[CheckListItem]>(value: [])
        
        input.addCheckList
            .subscribe(onNext: { checkList in
                var items = checkListItems.value
                items.append(CheckListItem(title: checkList, isDone: false))
                checkListItems.accept(items)
            })
            .disposed(by: disposeBag)
        
        input.editCheckList
            .subscribe(onNext: { (str, index) in
                var newCheckListItems = checkListItems.value
                newCheckListItems[index] = CheckListItem(title: str, isDone: newCheckListItems[index].isDone)
                checkListItems.accept(newCheckListItems)
            })
            .disposed(by: disposeBag)
        
        input.removeCheckList
            .subscribe(onNext: { index in
                var newCheckListItems = checkListItems.value
                newCheckListItems.remove(at: index)
                checkListItems.accept(newCheckListItems)
            })
            .disposed(by: disposeBag)
        
        input.tapCheckBox
            .subscribe(onNext: { (isDone, index) in
                var newCheckListItems = checkListItems.value
                newCheckListItems[index] = CheckListItem(title: newCheckListItems[index].title, isDone: isDone)
                checkListItems.accept(newCheckListItems)
            })
            .disposed(by: disposeBag)
        
        return Output(checkListItems: checkListItems)
    }
}
