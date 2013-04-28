package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Score extends MovieClip {
		var _root:Object;
		
		public function Score() {
			addEventListener(Event.ENTER_FRAME,eFrame)
			addEventListener(Event.ADDED_TO_STAGE,beginClass)
		}
		private function eFrame(e:Event){
			score.text = _root.score+""
		}
		private function beginClass(e:Event){
			_root = MovieClip(root)
		}
		
	}
	
}
