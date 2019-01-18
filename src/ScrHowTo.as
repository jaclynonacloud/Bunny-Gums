package  
{
	/**
	 * ...
	 * @author Jaclyn Staples
	 */
	
	import flash.display.*;
	import flash.events.*;
	
	
	public class ScrHowTo extends MovieClip {
		//declare event constants
		public static const FINISHED:String = "finished";
		//declare skins
		private var sHTP:ScreenHowTo;
		//declare player
		public var player:Player;
		//declare variables
		private var pgCount:int; //holds a number revelant to the number of pages clicked through
		
		public function ScrHowTo(currPlayer:Player) {
			
			//initialize skins
			sHTP = new ScreenHowTo();
			addChild(sHTP);
			//setup player
			player = currPlayer;
			//initialize variables
			pgCount = 1;	
			//event listeners
			sHTP.addEventListener(MouseEvent.MOUSE_UP, onClick);
		}
		
		//-------------------------------------------------------------event handlers
		private function onClick(e:MouseEvent):void {
			pgCount++;
			//changes pages according to the page count
			//makes it possible to have animated instructions later on
			if (pgCount <= 1) sHTP.gotoAndStop("pg1");
			if (pgCount == 2) sHTP.gotoAndStop("pg2");
			if (pgCount == 3) sHTP.gotoAndStop("pg3");
			if (pgCount == 4) sHTP.gotoAndStop("pg4");
			if (pgCount == 5) sHTP.gotoAndStop("pg5");
			if (pgCount == 6) sHTP.gotoAndStop("pg6");
			if (pgCount >=  7) {
				dispatchEvent(new Event(ScrHowTo.FINISHED));
				hideMe();
				pgCount = 1;
				sHTP.gotoAndStop("pg1");
			}
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