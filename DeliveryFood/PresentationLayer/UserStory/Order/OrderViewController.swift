//
//  OrderView.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 5/1/25.
//

import UIKit

class OrderViewController: UIViewController {
    
    private var orders: [DishOrderModel] = []
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "OrderCell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
        setupViews()
        setupConstraints()
    }
    
    private func configure() {
        title = "Your Order"
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupViews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func addDishToOrder(_ dish: DishOrderModel) {
        // Проверка, есть ли уже такое блюдо
        if let index = orders.firstIndex(where: { $0.name == dish.name }) {
            let existing = orders[index]
            orders[index] = DishOrderModel(name: existing.name, price: existing.price, quantity: existing.quantity + dish.quantity)
        } else {
            orders.append(dish)
        }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension OrderViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let order = orders[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath)

        let total = order.price * Double(order.quantity)
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.text = "\(order.name)\nQty: \(order.quantity) • Total: $\(String(format: "%.2f", total))"

        return cell
    }
}

extension OrderViewController: DescriptionViewControllerDelegate {
    func didAddDishToOrder(_ dish: DishOrderModel) {
        addDishToOrder(dish)
    }
}
