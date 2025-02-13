class_name PlayerColor
enum
{
	RED,
	BLUE,
	WHITE,
	YELLOW,
	GREEN,
	BROWN
}

static func get_rgb(color : int) -> Color:
	match color:
		RED:
			return Color.RED
		BLUE:
			return Color.BLUE
		WHITE:
			return Color.WHITE
		YELLOW:
			return Color.YELLOW
		GREEN:
			return Color.GREEN
		BROWN:
			return Color.BROWN
		_:
			return Color.BLACK
