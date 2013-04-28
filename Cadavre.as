package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Cadavre extends MovieClip {
		var _root:Object
		var pla:Boolean = true;

		
		public function Cadavre(id:int,X:int,Y:int) {
			this.gotoAndStop(id)
			addEventListener(Event.ENTER_FRAME,eFrame)
			addEventListener(Event.ADDED_TO_STAGE,beginClass)
			x=X
			y=Y;
		}
		private function eFrame(e:Event){
			if(pla)y--;
			if(y<-5&&this.parent!=null){
				for(var i:int = 0; i<_root.jeu.Cadavres.length; i++){
					if(_root.jeu.Cadavres[i]==this)_root.jeu.Cadavres.splice(i,1)
				}
				this.parent.removeChild(this)
			}
		}		
		
		function beginClass(e:Event){
			_root = MovieClip(root)
			_root.jeu.Algues.push(this)
		}
		function Pause(){
			pla=false;
		}
		function Play(){
			pla=true;
		}

	}
	
}
