package  
{
	/**
	 * ...
	 * @author Jaclyn Staples
	 */
	
	import flash.display.*;
	import flash.events.*;
	
	
	public class ScrSumm extends MovieClip {
		//declare event constants
		public static const FINISHED:String = "finished";
		public static const SHOW_START:String = "showStart";
		public static const SHOW_GAME:String = "showGame";
		//declare skins
		private var sSumm:ScreenSumm;
		//declare player
		public var player:Player;
		//declare toggle
		private var firstClick:Boolean;
		
		public function ScrSumm(currPlayer:Player) {
			//initialize skins
			sSumm = new ScreenSumm();
			addChild(sSumm);
			//setup player
			player = currPlayer;
			
			//event listeners
			sSumm.addEventListener(MouseEvent.MOUSE_UP, onClick, true);
		}
		
		//-------------------------------------------------------------event handlers
		private function onClick(e:MouseEvent):void {
			if(player.sndFX){
					player.playButton();
			}
			if (sSumm.txtInitials.text == "") {
				if (firstClick) {
					if ((e.target.name == "btnContinue") || (e.target.name == "btnExit")) sSumm.popUpdate.text = "Are you sure you don't want to add your initials to scoreboard?  Click again to continue without adding initials.";
					firstClick = false;
				}else if (!firstClick) {
					if (e.target.name == "btnContinue") {
						player.currScore = 0;
						dispatchEvent(new Event(ScrSumm.SHOW_GAME));
						hideMe();
					}
					if (e.target.name == "btnExit") {
						player.currScore = 0;
						dispatchEvent(new Event(ScrSumm.SHOW_START));
						hideMe();
					}
				}
			}else{
				if (e.target.name == "btnContinue") {
					player.currScore = 0;
					dispatchEvent(new Event(ScrSumm.SHOW_GAME));
					hideMe();
				}
				if (e.target.name == "btnExit") {
					player.currScore = 0;
					dispatchEvent(new Event(ScrSumm.SHOW_START));
					hideMe();
				}
			}
		}
		
		
		//-------------------------------------------------------------methods
		public function showMe(root:MovieClip):void {
			root.addChild(this);
			
			//define setup
			//setup variables
			firstClick = true;
			//update text boxes
			sSumm.txtInitials.text = player.initials;
			sSumm.txtFinScore.text = String(player.currScore);
			//if current score is larger than high score, tell player!
			if (player.currScore > player.highScore) {
				sSumm.popUpdate.text = "NEW HIGH SCORE!";
				player.highScore = player.currScore;
			}else {
				//pick random text from generator
				generateText(randomRange(1, 10));
			}
			
		}
		
		public function hideMe():void {
			parent.removeChild(this);
			player.initials = sSumm.txtInitials.text;
			trace(player.initials);
		}
		
		private function generateText(randomPlz:int):void {
			switch (randomPlz) {
				case 1:
					sSumm.popUpdate.text = "Would you eat a gummy bunny?  I would...";
					break;
				case 2:
					sSumm.popUpdate.text = "3.14 bunnies approve this game.";
					break;
				case 3:
					sSumm.popUpdate.text = "Your score is all right, I guess.";
					break;
				case 4:
					sSumm.popUpdate.text = "Gummy bunnies probably listen to dubstep.";
					break;
				case 5:
					sSumm.popUpdate.text = "If you're reading this, \"Hello\".";
					break;
				case 6:
					sSumm.popUpdate.text = "Like this game?  Don't be afraid to let the developer know.  That's me!";
					break;
				case 7:
					sSumm.popUpdate.text = "Dancing releases stress.";
					break;
				case 8:
					sSumm.popUpdate.text = "This text is a lie.";
					break;
				case 9:
					sSumm.popUpdate.text = "Canada has a polar bear infestation.  I'm scared to leave my igloo.";
					break;
				case 10:
					sSumm.popUpdate.text = "Someday I'll say something witty.";
					break;
				default: 
					sSumm.popUpdate.text = "Shout out to shout outs.";

			}
		}
		
		private function randomRange(minNum:Number, maxNum:Number):Number {
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
	}

}