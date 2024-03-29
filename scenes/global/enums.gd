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


enum EDamageType
{
	None,
	Physical,
	Magical,
	Both
}
