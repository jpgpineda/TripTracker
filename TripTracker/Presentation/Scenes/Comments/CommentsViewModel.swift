//
//  CommentsViewModel.swift
//  TripTracker
//
//  Created by javier pineda on 13/05/24.
//

import Foundation
import Combine

@MainActor
class CommentsViewModel {
    private var cancelBag = Set<AnyCancellable>()
    private let useCase: PostUseCase
    let input = Input()
    let output = Output()
    private var description: String = .empty
    
    class Input {
        let addNewComment = PassthroughSubject<Int, Never>()
        let addLikeToComment = PassthroughSubject<CommentIdentity, Never>()
        let updateComment = PassthroughSubject<String, Never>()
    }
    
    class Output {
        let showLoader = PassthroughSubject<Bool, Never>()
        let showMessage = PassthroughSubject<String, Never>()
        let resetForm = PassthroughSubject<Void, Never>()
    }
    
    init(useCase: PostUseCase) {
        self.useCase = useCase
        bind()
    }
    
    private func bind() {
        input.addNewComment.sink { [weak self] postId in
            guard let self = self else { return }
            let parameters = MakeComment(postId: postId, 
                                         description: self.description,
                                         from: User(from: UserDTO()))
            let request = AddNewCommentRequest(parameters: parameters)
            self.output.showLoader.send(true)
            Task {
                let response = await self.useCase.addNewComment(parameters: request)
                self.output.showLoader.send(false)
                switch response {
                case .success(let message):
                    self.output.showMessage.send(message)
                    self.description = .empty
                    self.output.resetForm.send()
                case .failure(let apiError):
                    self.output.showMessage.send(apiError.customDescription)
                }
            }
        }.store(in: &cancelBag)
        
        input.updateComment.sink { [weak self] comment in
            self?.description = comment
        }.store(in: &cancelBag)
        
        input.addLikeToComment.sink { [weak self] commentInfo in
            guard let self = self else { return }
            let parameters = AddLikeToComment(postId: commentInfo.postId,
                                              commentId: commentInfo.commetId,
                                              from: User(from: UserDTO()))
            let request = AddLikeToCommentRequest(parameters: parameters)
            self.output.showLoader.send(true)
            Task {
                let response = await self.useCase.addLikeToComment(parameters: request)
                self.output.showLoader.send(false)
                switch response {
                case .success(_):
                    self.description = .empty
                    self.output.resetForm.send()
                case .failure(let apiError):
                    self.output.showMessage.send(apiError.customDescription)
                }
            }
        }.store(in: &cancelBag)
    }
    
    func validateFields() -> Bool {
        var isValid = true
        if description.isEmpty {
            isValid = false
        }
        return isValid
    }
}
