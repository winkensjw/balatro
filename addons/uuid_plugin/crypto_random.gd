class_name CryptoRandom
extends BaseRandom 



func bytes(size: int) -> PackedByteArray:
	return Crypto.new().generate_random_bytes(size) 
