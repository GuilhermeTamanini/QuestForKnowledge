extends Resource

class_name IInventory

var inventoryPath: String
var inventory: Dictionary

func _init(invPath: String) -> void:
	inventoryPath = invPath

#func addItem(item: String) -> void:
	#inventory.set(item)
	#print("Added %s to inventory" % item)
#
#func removeItem(item: String) -> void:
	#inventory.erase(item)
	#print("Removed %s from inventory" % item)
#
#func saveInventory() -> void:
	#var file = FileAccess.open("user://%s_inventory.json" % playerId, FileAccess.WRITE)
#
	#if file:
		#file.store_string(JSON.stringify(inventory))
		#file.close()
		#print("Inventory saved for %s" % playerName)
#
#func loadInventory() -> void:
	#var file = FileAccess.open("user://%s_inventory.json" % playerId, FileAccess.READ)
#
	#if file:
		#inventory = JSON.parse_string(file.get_as_text())
		#file.close()
		#print("Inventory loaded for %s: %s" % [playerName, inventory])
