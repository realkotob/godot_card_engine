tool
class_name AnimationSequence
extends Reference

enum {INIT_DISABLED, INIT_ORIGIN, INIT_STEP}

var _to_mode: int
var _from_mode: int
var _data: Array = []


func _init(from_mode: int, to_mode: int) -> void:
	_from_mode = from_mode
	_to_mode = to_mode


func _default_transition() -> StepTransition:
	return StepTransition.new(0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)


func _default_value() -> StepValue:
	return StepValue.new(StepValue.Mode.FIXED)


func from_mode() -> int:
	return _from_mode


func to_mode() -> int:
	return _to_mode


func sequence() -> Array:
	return _data


func length() -> int:
	return _data.size()


func empty() -> bool:
	return _data.empty()


func init_sequence() -> void:
	if _from_mode != INIT_DISABLED:
		add_step(AnimationStep.new(
			null,
			StepValue.new(StepValue.Mode.INITIAL),
			false, false
		))
		
	add_step()
	
	if _to_mode != INIT_DISABLED:
		add_step(AnimationStep.new(
			_default_transition(),
			StepValue.new(StepValue.Mode.INITIAL),
			true, false
		))


func clear_sequence() -> void:
	_data.clear()


func step(index: int) -> AnimationStep:
	if index < 0 or index >= _data.size():
		return null

	return _data[index]


func add_step(step: AnimationStep = null) -> void:
	if step == null:
		step = AnimationStep.new(_default_transition(), _default_value())

	_data.append(step)


func remove_step(index: int) -> void:
	if index < 0 or index >= _data.size():
		return

	_data.remove(index)


func shift_step_left(index: int) -> void:
	if index <= 0 or index >= _data.size()-1:
		return

	Utils.shift_elt_left(_data, index)


func shift_step_right(index: int) -> void:
	if index <= 0 or index >= _data.size()-1:
		return

	Utils.shift_elt_right(_data, index)

