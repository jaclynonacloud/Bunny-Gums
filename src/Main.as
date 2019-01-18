package {
	import flash.desktop.*;
	import flash.system.fscommand;
	import flash.events.*;
	import flash.display.*;
	import flash.ui.*;
	import flash.geom.*;
	import flash.media.Sound;
	
	/**
	 * ...
	 * @author Jaclyn Staples
	 */
	public class Main extends MovieClip {
		
		//declare screens
		private var sStart:ScrStart;
		private var sGameA:ScrGameA;
		private var sGameB:ScrGameB;
		private var sGame:ScrGame;
		private var sPause:ScrPause;
		private var sSumm:ScrSumm;
		private var sHigh:ScrHigh;
		//declare player
		public var player:Player;
		private var uiCreated:Boolean = false;
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			// START HERE
			//initialization
			//setup player
			player = new Player();
			player.playBG();
			//setup screens
			sStart = new ScrStart(player);
			sGameA = new ScrGameA(player);
			sGameB = new ScrGameB(player);
			sGame = new ScrGame(player);
			sPause = new ScrPause(player);
			sSumm = new ScrSumm(player);
			uiCreated = true;
			
			
			//begin
			player.firstLogin = true;
			sStart.showMe(this);
			sGameA.mouseEnabled = false;
			
			//event listeners
				//screen events
			sStart.addEventListener(ScrStart.SHOW_START, gotoStart);
			sStart.addEventListener(ScrStart.SHOW_GAME, gotoGame);
			sStart.addEventListener(ScrStart.EXIT, deactivate);
			sSumm.addEventListener(ScrSumm.SHOW_START, gotoStart);
			sGameA.addEventListener(ScrGameA.PAUSED, gotoPause);
			sGameA.addEventListener(ScrGameA.FINISHED, gotoSumm);
			sGameA.addEventListener(ScrGameA.FINISHED, gameRemoval);
			sPause.addEventListener(ScrPause.SHOW_GAME, gotoGame);
			sPause.addEventListener(ScrPause.SHOW_START, gotoStart);
			sPause.addEventListener(ScrPause.SHOW_START, gameRemoval);
			sSumm.addEventListener(ScrSumm.SHOW_GAME, gotoGame);
			sSumm.addEventListener(ScrSumm.SHOW_START, gotoStart);
			
			// new to AIR? please read *carefully* the readme.txt files!
		}
		
		//---------------------------------------------------------------------------------------------event handlers
		
		//-----------------------------------------------------screen handlers
		private function gotoStart(e:Event):void {
			sStart.showMe(this);
		}
		private function gotoGame(e:Event):void {
			player.restart = false;
			sGameB.showMe(this);
			sGame.showMe(this);
			sGameA.showMe(this);
		}
		private function gotoPause(e:Event):void {
			sPause.showMe(this);
		}
		private function gotoSumm(e:Event):void {
			sSumm.showMe(this);
		}
		private function checkHowTo(e:Event):void {
			if (sPause.parent == sGame) {
				sGame.showMe(this);
			}else if (sPause.parent == sStart) {
				sStart.showMe(this);
			}
		}
		
		private function gameRemoval(e:Event):void {
			trace("Scene is cleared.");
			sGame.removeScene();
			
		}
		
		private function deactivate(e:Event):void {
			// make sure the app behaves well (or exits) when in background
			fscommand("quit");
		}
		
		}
		
	}
	