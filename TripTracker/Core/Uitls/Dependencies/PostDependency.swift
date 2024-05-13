//
//  PostDependency.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import Swinject

protocol PostDependency {
    var container: Container { get set }
    func makeCommentsViewController(postId: Int,
                                    comments: [CommentDTO]) -> CommentsViewController?
    func makeNewPostViewController() -> NewPostViewController?
}

class PostDependencyImplementation: PostDependency {
    var container: Container
    
    init(container: Container) {
        self.container = container
        registerCommentsViewController()
        registerNewPostViewController()
    }
    
    private func registerCommentsViewController() {
        container.register(CommentsViewController.self) { _ in
            return CommentsViewController()
        }
    }
    
    func makeCommentsViewController(postId: Int,
                                    comments: [CommentDTO]) -> CommentsViewController? {
        guard let viewController = container.resolve(CommentsViewController.self) else { return nil }
        viewController.postId = postId
        viewController.comments = comments
        return viewController
    }
    
    private func registerNewPostViewController() {
        container.register(NewPostViewController.self) { _ in
            return NewPostViewController()
        }
    }
    
    func makeNewPostViewController() -> NewPostViewController? {
        return container.resolve(NewPostViewController.self)
    }
}
