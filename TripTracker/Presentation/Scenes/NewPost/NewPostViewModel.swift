//
//  NewPostViewModel.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import Foundation
import Combine

@MainActor
class NewPostViewModel {
    var cancelBag = Set<AnyCancellable>()
    let useCase: PostUseCase
    let input = Input()
    let outPut = Output()
    var description: String = .empty
    var selectedImage: String = .empty
    
    class Input {
        let createNewPost = PassthroughSubject<Void, Never>()
        let updateDescription = PassthroughSubject<String, Never>()
        let updateImage = PassthroughSubject<String, Never>()
    }
    
    class Output {
        let showLoader = PassthroughSubject<Bool, Never>()
        let showMessage = PassthroughSubject<String, Never>()
        let dismissView = PassthroughSubject<Void, Never>()
    }
    
    init(useCase: PostUseCase) {
        self.useCase = useCase
        bind()
    }
    
    func bind() {
        input.createNewPost.sink { [weak self] _ in
            guard let self = self else { return }
            let parameters = MakePost(description: self.description,
                                      image: self.selectedImage,
                                      from: User(from: UserDTO()))
            let request = AddNewPostRequest(parameters: parameters)
            self.outPut.showLoader.send(true)
            Task {
                let response = await self.useCase.createNewPost(parameters: request)
                self.outPut.showLoader.send(false)
                switch response {
                case .success(let message):
                    self.outPut.dismissView.send()
                case .failure(let apiError):
                    self.outPut.showMessage.send(apiError.customDescription)
                }
            }
        }.store(in: &cancelBag)
        
        input.updateDescription.sink { [weak self] description in
            self?.description = description
        }.store(in: &cancelBag)
        
        input.updateImage.sink { [weak self] image in
            self?.selectedImage = image
        }.store(in: &cancelBag)
    }
    
    func validateFields() -> Bool {
        var isValid = true
        if description.isEmpty {
            isValid = false
        }
        if selectedImage.isEmpty {
            isValid = false
        }
        return isValid
    }
}
