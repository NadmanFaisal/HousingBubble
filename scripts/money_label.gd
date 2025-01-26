extends Label

func _on_hud_money_update(money: int) -> void:
	text = "Money: " + str(money) + "$"
