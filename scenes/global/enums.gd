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
	Right
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
	Challenge
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
