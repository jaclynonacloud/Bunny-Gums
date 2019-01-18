package  
{
	/**
	 * ...
	 * @author Jaclyn Staples
	 */
	import flash.display.*;
	import flash.events.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	public class Player {
		//declare constants
		private const DEFAULT_SCORE:int = 0;
		private const DEFAULT_HIGH:int = 0;
		private const DEFAULT_INITIALS:String = "";
		//declare variables
		private var _firstLogin:Boolean; //toggles if this is the first login for user -gives howtoplay when starting for first time
		private var _firstMatch:Boolean; // toggles if this is first move, so that match set knows when to start waiting for screw up.
		private var _resetMoves:Boolean; //toggles whether player has reset their moveset
		private var _outOfMoves:Boolean; //toggles when you took too many moves
		private var _gamePaused:Boolean; //toggles whether game is paused or not
		private var _restart:Boolean; //restarts game
		private var _mute:Boolean; //mutes the music
		private var _sndFX:Boolean; //mutes the sound effects
		//declare arrays
		private var _cSelect:Array; //selects color to be used on bunnies and jellies
		//setup sounds
		private var bgSound:SndBackground;
		private var bunSound:SndBunny;
		private var buttonSound:SndButton;
		private var bgChannel:SoundChannel;
		private var bunChannel:SoundChannel;
		private var buttonChannel:SoundChannel;
		
		//values
		private var _highScore:int; //holds the highscore
		private var _currScore:int; //holds the current score
		private var _initials:String; //holds the entered initials
		private var _diffNum:int; //holds the level difficulty which determines the number of diff colored bunnies
		
		public function Player() {
			setup();
		}
		
		//----------------------------------------------------------------methods
		public function setup():void {
			bgSound = new SndBackground();
			bunSound = new SndBunny();
			buttonSound = new SndButton();
			bgChannel = new SoundChannel();
			bunChannel = new SoundChannel();
			buttonChannel = new SoundChannel();
			_mute = true;
			_sndFX = true;
			_firstLogin = true;
			_resetMoves = false;
			_outOfMoves = false;
			_gamePaused = false;
			_restart = false;
			_diffNum = 3;
			_highScore = DEFAULT_HIGH;
			_currScore = DEFAULT_SCORE;
			_initials = DEFAULT_INITIALS;
			
		}
		
		public function playBG():void {
			bgChannel = bgSound.play();
			bgChannel.addEventListener(Event.SOUND_COMPLETE, onComplete);
		}
		public function stopBG():void {
			bgChannel.stop();
		}
		public function playBun():void {
			bunChannel = bunSound.play();
		}
		public function stopBun():void {
			bunChannel.stop();
		}
		public function playButton():void {
			buttonChannel = buttonSound.play();
		}
		public function stopButton():void {
			buttonChannel.stop();
		}
		
		//loop main sound
		private function onComplete(e:Event):void {
			bgChannel.removeEventListener(Event.SOUND_COMPLETE, onComplete);
			playBG();
		}
		
		//---------------------------------------------------------------getters and setters
		//first Login
		public function get firstLogin():Boolean {
			return _firstLogin;
		}
		public function set firstLogin(value:Boolean):void {
			_firstLogin = value;
		}
		//first match
		public function get firstMatch():Boolean {
			return _firstMatch;
		}
		public function set firstMatch(value:Boolean):void {
			_firstMatch = value;
		}
		//reset moves
		public function get resetMoves():Boolean {
			return _resetMoves;
		}
		public function set resetMoves(value:Boolean):void {
			_resetMoves = value;
		}
		//out of moves
		public function get outOfMoves():Boolean {
			return _outOfMoves;
		}
		public function set outOfMoves(value:Boolean):void {
			_outOfMoves = value;
		}
		//game Paused
		public function get gamePaused():Boolean {
			return _gamePaused;
		}
		public function set gamePaused(value:Boolean):void {
			_gamePaused = value;
		}
		//game restart
		public function get restart():Boolean {
			return _restart;
		}
		public function set restart(value:Boolean):void {
			_restart = value;
		}
		//mute
		public function get mute():Boolean {
			return _mute;
		}
		public function set mute(value:Boolean):void {
			_mute = value;
		}
		//snd effects
		public function get sndFX():Boolean {
			return _sndFX;
		}
		public function set sndFX(value:Boolean):void {
			_sndFX = value;
		}
		//difficulty number
		public function get diffNum():int {
			return _diffNum;
		}
		public function set diffNum(value:int):void {
			_diffNum = value;
		}
		//highscore
		public function get highScore():int {
			return _highScore;
		}
		public function set highScore(value:int):void {
			_highScore = value;
		}
		//current score
		public function get currScore():int {
			return _currScore;
		}
		public function set currScore(value:int):void {
			_currScore = value;
		}
		//initials
		public function get initials():String {
			return _initials;
		}
		public function set initials(value:String):void {
			_initials = value;
		}
		
	}

}