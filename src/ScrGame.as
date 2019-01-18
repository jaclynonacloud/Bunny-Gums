package
{
	/**
	 * ...
	 * @author Jaclyn Staples
	 * The game class controls all of the functionality residing in the center area of the game, including the bunny placement and color.
	 * @see Bunny
	 */
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Timer;
	
	public class ScrGame extends MovieClip{
		//declare event constants
		public static const FINISHED:String = "finished";
		public static const MATCHED:String = "matched";
		public static const DESTROYED:String = "destroyed";
		//declare player
		public var player:Player;
		//declare placement array
		private var correct:Array;
		private var order:Array;
		private var jellies:Array;
		private var bunnyNum:int;
		private var bunnyPlace:int;
		private var placeX:int;
		private var placeY:int;
		//declare jelly stuff
		private var jellyNum:int;
		private var jellyPlace:int;
		private var jellyCol:int;
		//declare the stupid timer
		private var timer:Timer;
		private var delay:int;
		//declare comparables
		private var clickCount:int;
		private var clickMax:int; //holds the number of clicks required to finish this string
		private var bunnyCol:int;
		private var newSet:Boolean; //makes a new set of stuff
		
		public function ScrGame(currPlayer:Player){
			//setup player
			player = currPlayer;
			timer = new Timer(delay, 0);
			clickCount = 0;
			bunnyCol = 0;
			bunnyNum = 56;
			jellyNum = 8;
			clickMax = 8;
			player.outOfMoves = false;
			player.firstMatch = true;
			setupArrays();
			
			//event listeners
			addEventListener(Event.ENTER_FRAME, onGameLoop);
			addEventListener(GamePiece.BUNNY_CLICKED, onClicked, true);
			addEventListener(ScrGame.MATCHED, onMatched);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		//-------------------------------------------------------------ARRAYS
		private function setupArrays():void {
			correct = new Array();
			if (player.firstMatch) {
				correct = [];
			}
			order = new Array();
			if (player.firstMatch) {
				for (var o:int = 0; o < order.length; o++) {
						order = [];
				}
			}
			jellies = new Array();
			if (player.firstMatch) {
				for (var j:int = 0; j < jellies.length; j++) {
						jellies = [];
				}
			}
		}
		
		//-------------------------------------------------------------event handlers
		private function onGameLoop(e:Event):void {
			if (newSet) {
					trace("Resetting Moves");
					resetMoves();
					newSet = false;
			}
		}
		private function onClicked(e:Event):void {
			player.firstMatch = false;
			clickCount++;
			bunnyCol = e.target.cPicker;
			order.push(bunnyCol);
			checkMatch();
			trace("Order String " + order.toString());
		}
		
		private function onMatched(e:Event):void {
				trace("You won so I\"m resetting");
				reset();
				addJellies();
				addBunnies();
		}
		
		private function onTimer(e:TimerEvent):void {
				trace("Timer has started");
				if (delay == 0) {
					trace("Timer has ended");
					player.outOfMoves = false;
					delay = 1;
					timer.reset();
				}else {
					delay--;
				}
		}
		
		//-------------------------------------------------------------methods
		private function checkMatch():void {	
			//setup a relation beween the number of jelly beans and the number of bunnies clicked
			trace("First jelly " + jellies[0] + ", First bunny " + order[0]);
			if ((correct.length == 0) && jellies[0] == order[0])	{
				trace("Jelly 0 matches Bunny 0.");
				correct.length++;
				trace(correct.length);
			}else if (jellies[0] != order[0]) {
				player.firstMatch = true;
				trace("Nope");
			}
			if ((correct.length == 1) && jellies[1] == order[1])	{
				trace("Jelly 1 matches Bunny 1.");
				correct.length++;
				trace(correct.length);
			}else if (jellies[1] != order[1]) {
				player.firstMatch = true;
			}
			if ((correct.length == 2) && jellies[2] == order[2])	{
				trace("Jelly 2 matches Bunny 2.");
				correct.length++;
				trace(correct.length);
			}else if (jellies[2] != order[2]) {
				player.firstMatch = true;
			}
			if ((correct.length == 3) && jellies[3] == order[3])	{
				trace("Jelly 3 matches Bunny 3.");
				correct.length++;
				trace(correct.length);
			}else if (jellies[3] != order[3]) {
				player.firstMatch = true;
			}	
			if ((correct.length == 4) && jellies[4] == order[4])	{
				trace("Jelly 4 matches Bunny 4.");
				correct.length++;
				trace(correct.length);
			}else if (jellies[4] != order[4]) {
				player.firstMatch = true;
			}
			if ((correct.length == 5) && jellies[5] == order[5])	{
				trace("Jelly 5 matches Bunny 5.");
				correct.length++;
				trace(correct.length);
			}else if (jellies[5] != order[5]) {
				player.firstMatch = true;
			}
			if ((correct.length == 6) && jellies[6] == order[6])	{
				trace("Jelly 6 matches Bunny 6.  You WIN!");
				player.currScore += 2500;
				dispatchEvent(new Event(ScrGame.MATCHED));
			}else if (jellies[6] != order[6]) {
				player.firstMatch = true;
			}	
			
			
			//check for click max- relative to the number of jellies
			if (order.length == clickMax){
				trace("you didn't get the matches");
				player.outOfMoves = true;
				timer.start();
				trace(player.outOfMoves);
				resetMoves();
				dispatchEvent(new Event(ScrGame.DESTROYED));
				
			}
			
			if (player.resetMoves) {
				trace("I've reset my move set.");
				player.resetMoves = false;
				setupArrays();
				
			}
		}
		
		public function addJellies():void{
			for (var i:int = 0; i < jellyNum - 1; i++){
				var jelly:GameMatch = new GameMatch(player);
				jelly.showMe(this);
				jelly.addJelly();
				jellyPlace = i;
				jellyCol = jelly.cPicker;
				jellies.push(jellyCol);
				
				//placement
				switch (jellyPlace){
					case 0: 
						jelly.x = 26;
						jelly.y = 75
						break;
					case 1: 
						jelly.x = 26;
						jelly.y = 126;
						break;
					case 2: 
						jelly.x = 26;
						jelly.y = 177
						break;
					case 3: 
						jelly.x = 26;
						jelly.y = 228;
						break;
					case 4: 
						jelly.x = 26;
						jelly.y = 279;
						break;
					case 5: 
						jelly.x = 26;
						jelly.y = 330;
						break;
					case 6: 
						jelly.x = 26;
						jelly.y = 381;
						break;
					default: 
				}
			}
			trace("JellyString " + jellies.toString());
			
			
		}
		
		public function addBunnies():void{
			for (var i:int = 1; i < bunnyNum; i++){
				//declare bunnies
				var bunny:GamePiece = new GamePiece(player);
				bunny.showMe(this);
				bunny.addBunny();
				bunny.x = placeX;
				bunny.y = placeY;
				bunnyPlace = i;
				bunnyCol = bunny.cPicker;
				if (bunny.x == 0){
					bunny.removeBunny();
				}
				
				//placement
				switch (bunnyPlace){
					case 0: //row 1
						placeX = 156;
						placeY = 76;
						break;
					case 1: 
						placeX = 210;
						placeY = 76;
						break;
					case 2: 
						placeX = 265;
						placeY = 76;
						break;
					case 3: 
						placeX = 319;
						placeY = 76;
						break;
					case 4: 
						placeX = 373;
						placeY = 76;
						break;
					case 5: 
						placeX = 428;
						placeY = 76;
						break;
					case 6: 
						placeX = 482;
						placeY = 76;
						break;
					case 7: 
						placeX = 537;
						placeY = 76;
						break;
					case 8: 
						placeX = 591;
						placeY = 76;
						break;
					case 9: 
						placeX = 645;
						placeY = 76;
						break;
					case 10: 
						placeX = 700;
						placeY = 76;
						break;
					case 11: //row 2
						placeX = 156;
						placeY = 152;
						break;
					case 12: 
						placeX = 210;
						placeY = 152;
						break;
					case 13: 
						placeX = 265;
						placeY = 152;
						break;
					case 14: 
						placeX = 319;
						placeY = 152;
						break;
					case 15: 
						placeX = 373;
						placeY = 152;
						break;
					case 16: 
						placeX = 428;
						placeY = 152;
						break;
					case 17: 
						placeX = 482;
						placeY = 152;
						break;
					case 18: 
						placeX = 537;
						placeY = 152;
						break;
					case 19: 
						placeX = 591;
						placeY = 152;
						break;
					case 20: 
						placeX = 645;
						placeY = 152;
						break;
					case 21: 
						placeX = 700;
						placeY = 152;
						break;
					case 22: //row 3
						placeX = 156;
						placeY = 228;
						break;
					case 23: 
						placeX = 210;
						placeY = 228;
						break;
					case 24: 
						placeX = 265;
						placeY = 228;
						break;
					case 25: 
						placeX = 319;
						placeY = 228;
						break;
					case 26: 
						placeX = 373;
						placeY = 228;
						break;
					case 27: 
						placeX = 428;
						placeY = 228;
						break;
					case 28: 
						placeX = 482;
						placeY = 228;
						break;
					case 29: 
						placeX = 537;
						placeY = 228;
						break;
					case 30: 
						placeX = 591;
						placeY = 228;
						break;
					case 31: 
						placeX = 645;
						placeY = 228;
						break;
					case 32: 
						placeX = 700;
						placeY = 228;
						break;
					case 33: //row 4
						placeX = 156;
						placeY = 304;
						break;
					case 34: 
						placeX = 210;
						placeY = 304;
						break;
					case 35: 
						placeX = 265;
						placeY = 304;
						break;
					case 36: 
						placeX = 319;
						placeY = 304;
						break;
					case 37: 
						placeX = 373;
						placeY = 304;
						break;
					case 38: 
						placeX = 428;
						placeY = 304;
						break;
					case 39: 
						placeX = 482;
						placeY = 304;
						break;
					case 40: 
						placeX = 537;
						placeY = 304;
						break;
					case 41: 
						placeX = 591;
						placeY = 304;
						break;
					case 42: 
						placeX = 645;
						placeY = 304;
						break;
					case 43: 
						placeX = 700;
						placeY = 304;
						break;
					case 44: //row 5
						placeX = 156;
						placeY = 380;
						break;
					case 45: 
						placeX = 210;
						placeY = 380;
						break;
					case 46: 
						placeX = 265;
						placeY = 380;
						break;
					case 47: 
						placeX = 319;
						placeY = 380;
						break;
					case 48: 
						placeX = 373;
						placeY = 380;
						break;
					case 49: 
						placeX = 428;
						placeY = 380;
						break;
					case 50: 
						placeX = 482;
						placeY = 380;
						break;
					case 51: 
						placeX = 537;
						placeY = 380;
						break;
					case 52: 
						placeX = 591;
						placeY = 380;
						break;
					case 53: 
						placeX = 645;
						placeY = 380;
						break;
					case 54: 
						placeX = 700;
						placeY = 380;
						break;
				}
			}
		}
		
		private function resetMoves():void {
			trace("Resetting Order");
				order = [];
				correct = [];
		}
		
		public function removeScene():void {
				player.outOfMoves = true;
				//removeChildren();
				reset();
		}
		
		public function showMe(root:MovieClip):void {
			player.outOfMoves = true;
			root.addChild(this);
			addBunnies();
			addJellies();
		}
		
		public function hideMe():void {
			player.outOfMoves = true;	
			parent.removeChild(this);
		}
		
		public function reset():void {
			clickCount = 0;
			bunnyCol = 0;
			bunnyNum = 56;
			jellyNum = 8;
			jellyPlace = 0;
			clickMax = 8;
			player.outOfMoves = false;
			player.firstMatch = true;
			newSet = false;
			setupArrays();
			trace("resetting...")
			trace("jellies length = " + jellies.length);
		}
		
		//---------------------------------------------------------------getters and setters
		
	}

}