import Foundation

class ConfigManager: ObservableObject {
    @Published var config: AppConfig = AppConfig()
    
    private let configURL = "https://raw.githubusercontent.com/yourusername/config/main/config.json"
    private let userDefaults = UserDefaults.standard
    private let configKey = "cached_config"
    
    init() {
        loadConfig()
    }
    
    func loadConfig() {
        if NetworkUtils.isNetworkAvailable() {
            loadRemoteConfig { [weak self] remoteConfig in
                DispatchQueue.main.async {
                    if let config = remoteConfig {
                        self?.config = config
                        self?.saveConfig(config)
                    } else {
                        self?.config = self?.getCachedConfig() ?? AppConfig()
                    }
                }
            }
        } else {
            self.config = getCachedConfig()
        }
    }
    
    private func loadRemoteConfig(completion: @escaping (AppConfig?) -> Void) {
        guard let url = URL(string: configURL) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let config = try JSONDecoder().decode(AppConfig.self, from: data)
                completion(config)
            } catch {
                print("Failed to decode config: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    private func saveConfig(_ config: AppConfig) {
        do {
            let data = try JSONEncoder().encode(config)
            userDefaults.set(data, forKey: configKey)
        } catch {
            print("Failed to save config: \(error)")
        }
    }
    
    private func getCachedConfig() -> AppConfig {
        guard let data = userDefaults.data(forKey: configKey) else {
            return AppConfig()
        }
        
        do {
            return try JSONDecoder().decode(AppConfig.self, from: data)
        } catch {
            print("Failed to decode cached config: \(error)")
            return AppConfig()
        }
    }
}