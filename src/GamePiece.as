package  
{
	/**
	 * ...
	 * @author Jaclyn Staples
	 * This class controls the Bunny MovieClip, which is essentially a game piece.
	 */
	import flash.display.*;
	import flash.events.*;
	import flash.media.Sound;
	
	
	public class GamePiece extends MovieClip {
		//declare event constants
		public static const BUNNY_CLICKED:String = "bunnyClicked";
		public static const BUNNY_REMOVED:String = "bunnyRemoved";
		//declare player
		public var player:Player;
		//declare skins
		private var bunny:Bunny;
		private var sGame:ScrGame;
		//declare variables
		private var isGlow:Boolean;
		private var _cPicker:int;
		private var usedBunnies:Array;
		
		public function GamePiece(currPlayer:Player) {

			//setup player
			player = currPlayer;
			sGame = new ScrGame(player);
			//setup sounds
			var bunSound:SndBunny = new SndBunny();
			
			//event listeners
			addEventListener(MouseEvent.MOUSE_UP, onClick, true);
			addEventListener(Event.ENTER_FRAME, onLoop);
		}
		//--------------------------------------------------------event handlers
		private function onClick(e:MouseEvent):void {
			//will make bunny glow if clicked
			if (!isGlow) {
				//add filter to bunny
				bunny.gotoAndStop(2);
				if(player.sndFX){
					player.playBun();
				}
				dispatchEvent(new Event(GamePiece.BUNNY_CLICKED));
				isGlow = true;
			}else {
				bunny.gotoAndStop(1);
				isGlow = false;
			}
		}
		
		//--------------------------------------------------------methods
		public function showMe(root:MovieClip):void {
			root.addChild(this);
		}
		
		public function hideMe():void {
			bunny.gotoAndStop(1);
			parent.removeChild(this);
		}
		
		public function addBunny():void {
			bunny = new Bunny();
			addChild(bunny);
			isGlow = false;
			//setup sizing
			bunny.width = 58;
			bunny.height = 77;
			//randomly pick a color for the bunny, and document it with a property
			var rNum:int = randomRange(1, player.diffNum);
			bunny.bColor.gotoAndStop(rNum);
			_cPicker = rNum;
		}
		
		public function removeBunny():void {
			bunny.gotoAndStop(1);
			removeChild(bunny);
		}
		
		private function randomRange(minNum:Number, maxNum:Number):Number {
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
		private function onLoop(e:Event):void {
			if (player.outOfMoves) {
				trace("dead");
				bunny.gotoAndStop(1);
			}
		}
		//---------------------------------------------------------------getters and setters
		//color picked
		public function get cPicker():int {
			return _cPicker;
		}
		//instance
		public function get instance():Bunny {
			return bunny;
		}
		public function set instance(value:Bunny):void {
			bunny = value;
		}
		

		

	
	}

}