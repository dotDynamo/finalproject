extends Control

@export var countdown_time : int
var countdown_decimals : int = 9

var hurryup_countdown : String

func _ready():
	update_counter()

func _on_seconds_timer_timeout():
	countdown_time -= 1
	update_counter()
	if countdown_time == 0:
		stop_timers()
	elif countdown_time < 11:
		hurryup_timer()

func _on_decimals_timer_timeout():
	countdown_decimals -= 1
	update_hurryup()
	if countdown_decimals == 0:
		countdown_decimals = 9

func update_counter():
	$RemainingSeconds.text = str(countdown_time)
	hurryup_countdown = str(countdown_time) + ".0"
	$FinalCountdown.text = hurryup_countdown

func update_hurryup():
	hurryup_countdown = str(countdown_time) + "." + str(countdown_decimals)
	$FinalCountdown.text = hurryup_countdown

func hurryup_timer():
	start_milisec()
	$FinalCountdown.show()
	$RemainingSeconds.hide()

func start_seconds():
	$SecondsTimer.start()

func start_milisec():
	$DecimalsTimer.start()

func stop_timers():
	$DecimalsTimer.stop()
	$SecondsTimer.stop()
