package  
{
	/**
	 * ...
	 * @author Jaclyn Staples
	 */
	
	import flash.display.*;
	import flash.events.*;
	
	
	public class ScrGameB extends MovieClip {
		//declare event constants
		public static const FINISHED:String = "finished";
		//declare skins
		private var sGameB:ScreenGameBelow;
		//declare player
		public var player:Player;
		
		public function ScrGameB(currPlayer:Player) {
			//initialize skins
			sGameB = new ScreenGameBelow();
			addChild(sGameB);
			//setup player
			player = currPlayer;
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