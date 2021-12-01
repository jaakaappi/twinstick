extends Label

const TIMESTEP = 750

var _last_tick_count = 0

func _process(delta):
	if OS.get_ticks_msec() > _last_tick_count + TIMESTEP:
		self.visible = !self.visible
		_last_tick_count = OS.get_ticks_msec()
