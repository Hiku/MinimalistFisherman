package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Bulle extends MovieClip {
		private var _root:Object;
		var k:int;
		var arrete:Boolean;
		var repris:Boolean;
		var taille:int;
		var temps:int;
		public function Bulle() {
			taille = Math.floor(Math.random()*6)+1
			temps = Math.floor(Math.random()*500)+50;
			k = 0;
			arrete = false;
			repris = false;
			this.addEventListener(Event.ENTER_FRAME,eFrame)
			this.addEventListener(Event.ADDED_TO_STAGE,beginClass)
		}
		function beginClass(e:Event){
			_root = MovieClip(root)
			_root.jeu.Bulles.push(this)
		}
		function eFrame(e:Event){
			if(currentFrame==taille){
				k++;
				if(!arrete)stop()
				arrete=true;
				if(k>temps)Exploser()
			} else if(currentFrame==8){
				Death()
			}
			y--;
		}
		function Death(){
			for(var i:int=0; i<_root.jeu.Bulles.length;i++){
				if(_root.jeu.Bulles[i]==this)_root.jeu.Bulles.splice(i,1)
			}
			if(this.parent!=null){
				this.removeEventListener(Event.ENTER_FRAME,eFrame)
				this.parent.removeChild(this)
			}
		}
		public function Exploser(){
			gotoAndPlay(7)
			repris=true;
		}
		
		public function Play(){
			this.addEventListener(Event.ENTER_FRAME,eFrame)
			if(repris||!arrete)play()
		}
		
		public function Pause(){
			this.removeEventListener(Event.ENTER_FRAME,eFrame)
			stop()
		}
	}
}
