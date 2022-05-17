//
//  ContactCell.swift
//  mvvm-example
//
//  Created by Jose Neves on 16/05/22.
//

import UIKit
import SwiftUI

final class ContactCell: UITableViewCell {
    
    lazy var nameLabel: UILabel = {
        var view = UILabel()
        view.textColor = .black
        
        return view
    }()
    
    lazy var iconImageView: UIImageView = {
        var view = UIImageView()
        
        return view
    }()
    
    static let identifier = "ContactCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContact(with contact: Contact) {
        nameLabel.text = contact.name
    }

}

extension ContactCell: ViewProtocol {
    func buildViews() {
        backgroundColor = .white
    }
    
    func configViews() {
        addSubViews([
            iconImageView,
            nameLabel
        ])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            iconImageView.heightAnchor.constraint(equalToConstant: 50),
            iconImageView.widthAnchor.constraint(equalToConstant: 50),
            
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8)
        ])
    }
}
