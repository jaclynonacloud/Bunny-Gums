package  
{
	/**
	 * ...
	 * @author Jaclyn Staples
	 */
	import flash.display.*;
	import flash.events.*;
	
	
	public class ScrPause extends MovieClip {
		//declare event constants
		public static const FINISHED:String = "finished";
		public static const SHOW_GAME:String = "showGame";
		public static const SHOW_HOWTO:String = "showHowTo";
		public static const SHOW_START:String = "showStart";
		//declare skins
		private var sPause:ScreenPause;
		private var sHTP:ScrHowTo;
		//declare player
		public var player:Player;
		//declare toggles
		private var loopToggle:Boolean;
		private var fxToggle:Boolean;
		
		public function ScrPause(currPlayer:Player) {
			//initialize skins
			sPause = new ScreenPause();
			addChild(sPause);
			sHTP = new ScrHowTo(player);
			//setup player
			player = currPlayer;
			//setup sounds
			loopToggle = true;
			fxToggle = true;
			
			//event listeners
			sPause.addEventListener(MouseEvent.MOUSE_UP, onClick, true);
		}
		
		//-------------------------------------------------------------event handlers
		private function onClick(e:MouseEvent):void {
			if (e.target.name == "btnContinue") { 
				if(player.sndFX){
					player.playButton();
				}
				hideMe();
			}
			if (e.target.name == "btnHowTo") {
				if(player.sndFX){
					player.playButton();
				}
				trace("Showing how to menu");
				sHTP.showMe(this);
			}
			if (e.target.name == "btnExit") {
				if(player.sndFX){
					player.playButton();
				}
				trace("Exitting pause menu");
				dispatchEvent(new Event(ScrPause.SHOW_START));
			}
			if (e.target.name == "sndLoop") {
				if (!loopToggle) {
					sPause.sndLoop.gotoAndStop(1);
					player.playBG();
					player.mute = true;
					loopToggle = true;
				}else if (loopToggle) {
					sPause.sndLoop.gotoAndStop(2);
					player.stopBG();
					player.mute = false;
					loopToggle = false;
				}
			}
			if (e.target.name == "sndFx") {
				if (!fxToggle) {
					sPause.sndFx.gotoAndStop(1);
					player.playBun();
					player.sndFX = true;
					fxToggle = true;
				}else if (fxToggle) {
					sPause.sndFx.gotoAndStop(2);
					player.stopBun();
					player.stopButton();
					player.sndFX = false;
					fxToggle = false;
				}
			}
		}
		
		private function onHowToFinish(e:Event):void {
			dispatchEvent(new Event(ScrPause.SHOW_GAME));
		}
		
		
		//-------------------------------------------------------------methods
		public function showMe(root:MovieClip):void {
			player.gamePaused = true;
			root.addChild(this);
		}
		
		public function hideMe():void {
			player.gamePaused = false;
			parent.removeChild(this);
		}
		
		//---------------------------------------------------------------getters and setters
		//instance
		public function get instance():ScreenPause {
			return sPause;
		}
		public function set instance(value:ScreenPause):void {
			sPause = value;
		}
		
	}


}