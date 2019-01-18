package  
{
	/**
	 * ...
	 * @author Jaclyn Staples
	 * This class controls inputs including the high score board.
	 */
	
	import flash.display.*;
	import flash.events.*;
	
	
	public class ScrHigh extends MovieClip{
		
		//declare event constants
		public static const SHOW_START:String = "showStart";
		public static const CLEAR_SCORES:String = "clearScores";
		//declare skins
		private var sHigh:ScreenHigh;
		//declare player
		public var player:Player;
		//declare toggles
		private var firstClick:Boolean;
		
		public function ScrHigh(currPlayer:Player) {
			//initialize skins
			sHigh = new ScreenHigh();
			addChild(sHigh);
			//setup player
			player = currPlayer;
			
			//event listeners
			sHigh.addEventListener(MouseEvent.MOUSE_UP, onClick, true);
		}
		
		//-------------------------------------------------------------event handlers
		private function onClick(e:MouseEvent):void {
			if (e.target.name == "btnMain") hideMe();
			else if (e.target.name == "btnClear") {
				if (firstClick) {
					sHigh.txtClearCheck.visible = true;
					firstClick = false;
				}else if (!firstClick) {
					dispatchEvent(new Event(ScrHigh.CLEAR_SCORES));
					sHigh.txtClearCheck.visible = false;
				}
			}
		}
		
		
		
		//-------------------------------------------------------------methods
		public function showMe(root:MovieClip):void {
			root.addChild(this);
			
			//define setup
			//setup variables
			sHigh.txtClearCheck.visible = false;
			firstClick = true;
		}
		
		public function hideMe():void {
			parent.removeChild(this);
		}
		
		public function clearScores():void {
			
		}
		
		public function clearAll():void {
			
		}
	}

}