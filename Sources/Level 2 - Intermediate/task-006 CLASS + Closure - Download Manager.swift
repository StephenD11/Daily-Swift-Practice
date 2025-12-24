import UIKit

//Задача №19 тестовая задача работы с DownloadManager, замыканием (observer), и перечислением (emun)


enum Events {
    case start(String)
    case finish(String)
    case cancel(String)
}

class DownloadManager {
    private var fileNames: [String] = []
    var onEvent: ((Events, [String]) -> Void)?
    
    init(fileNames: [String] = []) {
        self.fileNames = fileNames
    }
    
    func startDownload(file: String) {
        guard !fileNames.contains(file) else {
            print("Нельзя начинать загрузку файла, который уже загружается")
            return
        }
        
        fileNames.append(file)
        onEvent?(.start(file), fileNames)
        
    }
    
    func finishDownload(file: String) {
        guard fileNames.contains(file) else {
            print("Нельзя завершать загрузку файла, которого нет в списке. \(file) не может быть завершен")
            return
        }
        
        if let index = fileNames.firstIndex(of: file) {
            fileNames.remove(at:index)
            onEvent?(.finish(file), fileNames)
        }
    }
    
    func cancelDownload(file: String) {
        guard fileNames.contains(file) else {
            print("Нельзя отменить загрузку файла, которого нет в списке")
            return
        }
        
        if let index = fileNames.firstIndex(of: file) {
            fileNames.remove(at:index)
            onEvent?(.cancel(file), fileNames)
        }
    }
}


var manager: DownloadManager? = DownloadManager( fileNames: [])

manager?.onEvent = { action, files in
    switch action {
    case .start(let file):
        print("Началась загрузка файла \(file). Файлы в состоянии загрузки: \(files)")
    case .finish(let file):
        print("Файл \(file)  завершил загрузку. Файлы в состоянии загрузки: \(files)")
    case .cancel(let file):
        print("Загрузка файла \(file) отменена. Файлы в состоянии загрузки: \(files)")
        }
    }

manager?.startDownload(file: "Torrent.exe")
manager?.startDownload(file: "Banana.exe")
manager?.finishDownload(file: "Homepage.exe")
manager?.finishDownload(file: "Torrent.exe")

manager?.startDownload(file: "Minecraft.exe")
manager?.cancelDownload(file: "Minecraft.exe")
