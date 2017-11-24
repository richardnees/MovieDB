import Foundation
import MovieDBCore

extension DataSourceController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provider.totalItemCount
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return provider.totalItemCount > 0 ? provider.headerTitle : nil
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let provider = provider as? PagingNetworkDataSourceProviding {
            guard indexPath.row < provider.totalItemCount else {
                return tableView.dequeueReusableCell(withIdentifier: DataSourceLoadingCell.identifier, for: indexPath)
            }
        }
        
        let item = provider.items[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: item.cellIdentifier, for: indexPath)
        
        if var cell = cell as? DataSourceCellProtocol {
            cell.item = item
        }
        return cell as UITableViewCell
    }
        
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return provider.allowsEditing
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            provider.items.remove(at: indexPath.row)
            provider.update()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
