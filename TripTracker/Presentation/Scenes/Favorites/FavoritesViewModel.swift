//
//  FavoritesViewModel.swift
//  TripTracker
//
//  Created by javier pineda on 13/05/24.
//

import Foundation
import Combine

class FavoritesViewModel {
    var cancelBag = Set<AnyCancellable>()
    private let useCase: PostUseCase
    let input = Input()
    let output = Output()
    
    class Input {
        let viewDidLoad = PassthroughSubject<Void, Never>()
        let deleteFavorite = PassthroughSubject<PostDTO, Never>()
    }
    
    class Output {
        let showLoader = PassthroughSubject<Bool, Never>()
        let showMessage = PassthroughSubject<String, Never>()
        let updatePosts = PassthroughSubject<[PostDTO], Never>()
    }
    
    init(useCase: PostUseCase) {
        self.useCase = useCase
        bind()
    }
    
    private func bind() {
        input.viewDidLoad.sink { [weak self] _ in
            guard let self = self else { return }
            self.output.showLoader.send(true)
            if let posts = self.useCase.getFavoritesPosts() {
                self.output.showLoader.send(false)
                self.output.updatePosts.send(posts)
            } else {
                self.output.showLoader.send(false)
            }
        }.store(in: &cancelBag)
        
        input.deleteFavorite.sink { [weak self] post in
            guard let self = self else { return }
            self.output.showLoader.send(true)
            self.useCase.deleteFavorite(postId: post.id) { result in
                self.output.showLoader.send(false)
                switch result {
                case .success(_):
                    self.output.showMessage.send(.Localized.deletedPostConfirmation)
                case let .failure(error):
                    self.output.showMessage.send(error.customDescription)
                }
            }
        }.store(in: &cancelBag)
    }
}
