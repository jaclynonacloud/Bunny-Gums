package  
{
	/**
	 * ...
	 * @author Jaclyn Staples
	 */
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Timer;
	
	
	public class ScrGameA extends MovieClip {
		//declare event constants
		public static const FINISHED:String = "finished";
		public static const PAUSED:String = "paused";
		public static const RESET_MOVES:String = "resetMoves";
		//declare skins
		private var sGameA:ScreenGameAbove;
		//declare player
		public var player:Player;
		//declare timer
		private var timer:Timer;
		private var seconds:Number = 00;
		private var minutes:Number = 3;
		
		public function ScrGameA(currPlayer:Player) {
			//initialize skins
			sGameA = new ScreenGameAbove();
			addChild(sGameA);
			//setup player
			player = currPlayer;
			//setup variables
			sGameA.cornerTaps.doubleClickEnabled = true;  //allow for corners to be double clicked
			//setup timer
			timer = new Timer(1000, 180);
		}
		
		//-------------------------------------------------------------event handlers
		//handles game loop
		private function onLoop(e:Event):void {
		
			
			if (player.gamePaused) {
				//if game is paused, cease some functionality
				timer.stop();
			}else if (!player.gamePaused) {
				timer.start();
				//setup text boxes on every frame
				sGameA.txtTime.text = minutes + ":" + (seconds >= 10 ? seconds : "0" + seconds);
				sGameA.txtCurrScore.text = String(player.currScore);
				sGameA.txtHighScore.text = (String(player.highScore) + " " + player.initials);
				
			}
		}
		
		//handles is used cancels their current matchset
		private function onCancel(e:MouseEvent):void {
				//if this is the player's first move, don't show the cancel button
				if (!player.firstMatch) {
					if (!player.resetMoves) {
						sGameA.btnCancel.visible = true;
					}
				}else{
					sGameA.btnCancel.visible = false;
				}
				
				trace("Moves have been reset.");
				sGameA.btnCancel.visible = false;
				player.resetMoves = true;
				dispatchEvent(new Event(ScrGameA.RESET_MOVES));
		}
		
		
		//handles when user double taps any of the corners
		private function onCornerTaps(e:MouseEvent):void {
			trace("I'm clicked doubly!");
			dispatchEvent(new Event(ScrGameA.PAUSED));
		}
		
		//handles time left in game
		private function onTimer(e:TimerEvent):void {
			if (seconds > 00) {
				seconds -=1;
			} else {
				if (minutes > 0) {minutes -=1;seconds = 59;}
			} 
			
			//handles what happens once game time is up
				//set to 00 00 when done debugging
			if (seconds == 00 && minutes == 00) {
				dispatchEvent(new Event(ScrGameA.FINISHED));
				reset();
				player.diffNum = 3;
				player.restart = true;
			}
			
			if (seconds % 30 == 0) {
				if (player.diffNum >= 14) {
					player.diffNum = 14;
				}else {
					player.diffNum += 2;
				}
				
				trace("Im more difficult now!");
			}
		}
		
		//-------------------------------------------------------------methods
		public function showMe(root:MovieClip):void {
			root.addChild(this);
			//setup all parameters
			setup();
		}
		
		public function hideMe():void {
			parent.removeChild(this);
		
			//reset all parameters
			reset();
		}
		
		//called to setup game scene whenever game is restarted
		public function setup():void {
			//initialization
			//setup timer
			timer.start();
			sGameA.txtTime.text = "3:00";
			//reset values
			seconds = 00;
			minutes = 3;
			sGameA.txtCurrScore.text = String(player.currScore);
			sGameA.txtHighScore.text = String(player.highScore);
			player.gamePaused = false;
			sGameA.btnCancel.visible = false;
			
			//event listeners
			sGameA.addEventListener(Event.ENTER_FRAME, onLoop);
			sGameA.btnCancel.addEventListener(MouseEvent.MOUSE_UP, onCancel);
			sGameA.cornerTaps.addEventListener(MouseEvent.DOUBLE_CLICK, onCornerTaps);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		//called to clear game scene when screen is left
		public function reset():void {
			timer.reset();
			//remove event listeners
			sGameA.removeEventListener(Event.ENTER_FRAME, onLoop);
			sGameA.cornerTaps.removeEventListener(MouseEvent.DOUBLE_CLICK, onCornerTaps);
			timer.removeEventListener(TimerEvent.TIMER, onTimer);
		}
		
	}

}