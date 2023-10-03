extends Node


enum EState
{
	Idle,
	Walk,
	Run,
	Damage,
	Appearing,
	Disappearing
}

enum EDirection
{
	Left,
	Right,
	Up,
	Down
}

enum EnemySize
{
	Normal,
	Large,
	Huge
}

enum EnemyType
{
	Common,
	Rare,
	Boss
}

enum EMap
{
	Forest,
	Cave,
	Desert,
	Tundra,
	Tower
}

enum ETransitionDirection
{
	Normal,
	Reverse
}

enum EViewportEffect
{
	Normal,
	CRT,
	Gray
}

enum ECameraEffect
{
	Expand,
	Shock
}
