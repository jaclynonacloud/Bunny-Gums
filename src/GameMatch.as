package  
{
	/**
	 * ...
	 * @author Jaclyn Staples
	 * This class takes care of the jellybeans, which will match the bunnies
	 */
	import flash.display.*;
	import flash.events.*;
	public class GameMatch extends MovieClip {
		//declare skins
		private var jelly:Jelly;
		//declare color matcher
		private var _cPicker:int;
		//declare player
		public var player:Player;
		
		public function GameMatch(currPlayer:Player) {
			//setup player
			player = currPlayer;
			
		}
		
		//--------------------------------------------------------methods
		public function showMe(root:MovieClip):void {
			root.addChild(this);
		}
		
		public function hideMe():void {
			parent.removeChild(this);
		}
		
		public function addJelly():void {
			//setup skins
			jelly = new Jelly();
			addChild(jelly);
			//resize
			jelly.width = 110;
			jelly.height = 230;
			//randomly pick a color for the jelly, and document it with a property
			var rNum:int = randomRange(1, player.diffNum);
			jelly.jColor.gotoAndStop(rNum);
			_cPicker = rNum;
		}
		
		public function removeJelly():void {
			removeChild(jelly);
		}
		
		private function randomRange(minNum:Number, maxNum:Number):Number {
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
		//---------------------------------------------------------------getters and setters
		//color picked
		public function get cPicker():int {
			return _cPicker;
		}
		
	}

}