package  
{
	/**
	 * ...
	 * @author Jaclyn Staples
	 */
	
	import flash.display.*;
	import flash.events.*;
	
	
	public class ScrStart extends MovieClip {
		//declare event constants
		public static const FINISHED:String = "finished";
		public static const SHOW_START:String = "showStart";
		public static const SHOW_HOWTO:String = "showHowTo";
		public static const SHOW_GAME:String = "showGame";
		public static const SHOW_HIGH:String = "showHigh";
		public static const EXIT:String = "exit";
		//declare skins
		private var sStart:ScreenStart;
		private var sHTP:ScrHowTo;
		private var sHigh:ScrHigh;
		//declare player
		public var player:Player;
		//declare variables
		private var loader:Loader;
		
		public function ScrStart(currPlayer:Player) {
			//setup skins
			sStart = new ScreenStart();
			addChild(sStart);
			sHTP = new ScrHowTo(player);
			sHigh = new ScrHigh(player);
			//setup player
			player = currPlayer;
			//initial loading setup
			sStart.loadWheel.visible = false;
			
			//event listeners
			sStart.addEventListener(MouseEvent.MOUSE_UP, onClick, true);
			sHigh.addEventListener(ScrHigh.CLEAR_SCORES, clearScores);
		}
		
		//-------------------------------------------------------------event handlers
		private function onClick(e:MouseEvent):void {
			if(player.sndFX){
					player.playButton();
			}
			//if player's first time playing game this session, the how to play pop-up will come up automatically
			if (e.target.name == "btnStart" && player.firstLogin) {
				sHTP.showMe(this);
				sHTP.addEventListener(ScrHowTo.FINISHED, onHowToFinish);
				player.firstLogin = false;
			}else if (e.target.name == "btnStart" && !player.firstLogin) {
				dispatchEvent(new Event(ScrStart.SHOW_GAME));
			}else if (e.target.name == "btnHigh") {
				sHigh.showMe(this);
				sHTP.addEventListener(ScrHowTo.FINISHED, onHowToReturn);
			}else if (e.target.name == "btnHTP") {
				sHTP.showMe(this);
			}else if (e.target.name == "btnExit") {
				dispatchEvent(new Event(ScrStart.EXIT));
			}
		}
		
		private function onHowToFinish(e:Event):void {
			dispatchEvent(new Event(ScrStart.SHOW_GAME));
		}
		
		private function onHowToReturn(e:Event):void {
			dispatchEvent(new Event(ScrStart.SHOW_START));
		}
		
		private function clearScores(e:Event):void {
			trace("I'm gonna clear now.");
		}
		
		
		//-------------------------------------------------------------methods
		public function showMe(root:MovieClip):void {
			root.addChild(this);
		}
		
		public function hideMe():void {
			parent.removeChild(this);
		}	
	}
}