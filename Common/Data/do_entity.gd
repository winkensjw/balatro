class_name DoEntity
extends RefCounted

var attribute_name: String
var lazy_create: Callable = Callable()
var value: Variant


func _init(attribute_name: String = "", lazy_create: Callable = Callable(), initial_value: Variant = null) -> void:
	self.attribute_name = attribute_name
	self.lazy_create = lazy_create
	self.value = initial_value


func exists() -> bool:
	return lazy_create.is_null()


func create() -> DoNode:
	if not lazy_create.is_null():
		lazy_create.call(self)
		lazy_create = Callable()
	return self


func getValue() -> Variant:
	return value


func setValue(new_value: Variant) -> void:
	create()
	value = new_value


func to_optional() -> Variant:
	if exists():
		return value if value != null else null
	return null


func if_present(consumer: Callable) -> void:
	if exists() and not consumer.is_null():
		consumer.call(value)


func set_attribute_name(new_name: String) -> void:
	attribute_name = new_name


func get_attribute_name() -> String:
	return attribute_name


func _hash() -> int:
	var prime := 31
	var result := 1
	result = prime * result + (1231 if exists() else 1237)
	result = prime * result + (attribute_name.hash() if attribute_name != "" else 0)
	result = prime * result + value_hash_code()
	return result


func value_hash_code() -> int:
	return value.hash() if value != null else 0


func _equals(other: DoNode) -> bool:
	if other == null or not (other is DoNode):
		return false
	if exists() != other.exists():
		return false
	if attribute_name != other.attribute_name:
		return false
	return value_equals(other)


func value_equals(other: DoNode) -> bool:
	return value == other.value
