import UIKit

enum PlayerEvent {
    case play(String)
    case pause(String)
    case stop(String)
    case queueUpdated([String])
}


class MusicPlayer {
    private var musicList: [String] = []
    private var currentSong: String = ""
    var onEvent: ((PlayerEvent) -> Void)?
    
    init(currentSong:String = "", musicList: [String]) {
        self.currentSong = currentSong
        self.musicList = musicList
    }
    
    func addToQueue(song: String) {
        guard !song.isEmpty else {
            print("Такой песни не существует. Введена пустая строка")
            return
        }
        
        musicList.append(song)
        onEvent?(.queueUpdated(musicList))
    }
    
    func removeFromQueue(song: String) {
        guard musicList.contains(song) else {
            print("Такой песни нет в очереди. Введена пустая строка")
            return
        }
        
        if let index = musicList.firstIndex(of: song) {
            musicList.remove(at: index)
            onEvent?(.queueUpdated(musicList))
            
        }
    }
    
    func play(song: String) {
        guard musicList.contains(song) else {
            print("Невозможно запустить \(song). Такой песни не существует")
            return
        }
        
        currentSong = song
        onEvent?(.play(song))
        
    }
    
    func pause() {
        guard !currentSong.isEmpty else {
            print("Невозомжно поставить на паузу. Ни одна песни не играет")
            return
        }
        
        onEvent?(.pause(currentSong))
        
    }
    
    func stop() {
        guard !currentSong.isEmpty else {
            print("Невозомжно остановить. Ни одна песни не играет")
            return
        }
        
        currentSong = ""
        onEvent?(.stop(currentSong))
        
    }
    
}

var playlist: MusicPlayer? = MusicPlayer(musicList:[])

playlist?.onEvent = { event in
    switch event {
    case .queueUpdated(let songs):
        print("Очередь обновлена: \(songs)")
    case .play(let song):
        print("Играет песня \(song)")
    case .stop(let song):
        print("Песня \(song) остановлена ")
    case .pause(let song):
        print("Песня на паузе \(song)")
    }
}

playlist?.addToQueue(song: "My Way - Frank Sinatra")
playlist?.addToQueue(song: "Show must go on - Freddy Mercury")

playlist?.play(song: "My Way - Frank Sinatra" )
playlist?.pause()
playlist?.stop()

playlist?.removeFromQueue(song: "My Way - Frank Sinatra")
