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
