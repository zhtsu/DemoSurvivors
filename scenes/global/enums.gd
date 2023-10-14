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

enum ItemType
{
	Ability,
	Weapon
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
