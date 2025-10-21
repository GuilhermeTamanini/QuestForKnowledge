# MusicManager.gd
extends Node

var musicPlayer: AudioStreamPlayer
var currentMusic: AudioStream = null
const MUSICS_PATH = {
	GameEnums.MusicEnum.BATTLE: preload("res://assets/soundtracks/LetsBattle.mp3"),
	GameEnums.MusicEnum.OVERWORLD: preload("res://assets/soundtracks/QFK_Overworld.mp3")
}

func _ready():
	musicPlayer = AudioStreamPlayer.new()
	add_child(musicPlayer)
	musicPlayer.bus = "Music"

func playMusic(music: GameEnums.MusicEnum, loop: bool = true):
	var stream = MUSICS_PATH.get(music, null)
	if stream == null:
		push_warning("Music not found: %s" % music)
		return

	if stream == currentMusic:
		return

	currentMusic = stream
	musicPlayer.stop()
	musicPlayer.stream = stream
	musicPlayer.play()

func stopMusic():
	musicPlayer.stop()
	currentMusic = null

func pauseMusic():
	musicPlayer.stream_paused = true

func resumeMusic():
	musicPlayer.stream_paused = false
