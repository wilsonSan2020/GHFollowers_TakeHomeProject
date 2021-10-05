//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Wilson Sanchez on 1/20/20.
//  Copyright © 2020 wtech22. All rights reserved.
//

import UIKit

protocol UserInfoVCDelegate : AnyObject {
    // list of commands/functions available to us
    func didTapGitHubProfile(for user: User) //passing user through our delegate
    func didTapGetFollowers(for user: User)
}

class UserInfoViewController: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    
    var username : String!
    weak var delegate: FollowerListVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        layouUI()
        getUserInfoFromNetwork()
       
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfoFromNetwork() {
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
                   
                    guard let self = self else {return}
                   
                    switch result {
                    case .success(let user):
                        DispatchQueue.main.async { self.configureUIElements(with: user)
                        }
                        
                    case .failure(let error):
                        self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                    }
               }//end of netwk call
    }
    
    func configureUIElements(with user : User) {
        
        let repoItemVC          = GFRepoItemViewController(user : user)
        repoItemVC.delegate     = self
        
        let followerItemVC      = GFFollowerItemViewController(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: GFUserInfoHeaderViewController(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        //self.dateLabel.text = user.createdAt.convertToDisplayFormat()
        self.dateLabel.text = "GitHub since \(user.createdAt.convertToDisplayFormat())"
    }
    
    func layouUI() {
        view.addSubview(headerView)
        view.addSubview(itemViewOne)
        view.addSubview(itemViewTwo)
        view.addSubview(dateLabel)
        
        //itemViewOne.backgroundColor = .systemPink
        //itemViewTwo.backgroundColor = .blue
        
        headerView.translatesAutoresizingMaskIntoConstraints = false //tamic
        itemViewOne.translatesAutoresizingMaskIntoConstraints = false
        itemViewTwo.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let padding : CGFloat = 20
        let itemHeight : CGFloat = 140
        
        //headerView.backgroundColor = .systemPink
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 190),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)

        ])
    }
    
    //adding a childVC to a containerView
    func add(childVC : UIViewController, to containerView : UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds //to fill up the whole container view
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }


}




extension UserInfoViewController : UserInfoVCDelegate {
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        
        presentSafariVC(with: url)
        
    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No Followers", message: "This user has no followers. What a shame team", buttonTitle: "So sad!")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
    
    
    
    
}
