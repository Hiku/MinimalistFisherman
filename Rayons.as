package  {
	import flash.geom.Point;
	import flash.filters.BlurFilter;
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class Rayons extends MovieClip {
		private var Qualite:int;
		private var Borne1:Number;
		private var Borne2:Number;
		public var ptBase:Point;
		private var nb:int;
		private var longueur:int;
		private var rayons:Array;
		private var depla:Array;

		
		
		public function Rayons(AngleMin:Number,AngleMax:Number,Base:Point,Quali:int,Long:int) {
			Qualite = Quali;
			Borne1 = Math.PI/8;
			Borne2 = 3*Math.PI/4;
			ptBase = new Point(150,-30);
			nb = Qualite;
			longueur = Long;
			rayons = new Array();
			depla = new Array();
			CreerRayons()
			AfficherRayons()
			this.addEventListener(Event.ENTER_FRAME, eFrame)
		}
		function CreerRayons(){
			for(var i:int = 0; i<nb; i++){
				rayons.push(Math.random()*(Borne2-Borne1) + Borne1)
				depla.push((Math.random()-0.5)*0.005)
			}
		}
		function AfficherRayons(){
			//trace(ptBase.y)
			graphics.clear()
			for(var i:int = 0; i<rayons.length; i++){
				graphics.lineStyle(32,0xFFFFFF,1/Math.pow(Qualite,0.5))
				graphics.moveTo(ptBase.x,ptBase.y)
				graphics.lineTo(Math.cos(rayons[i])*longueur+ptBase.x,Math.sin(rayons[i])*longueur+ptBase.y)
			}
		}
		function eFrame(e:Event){
			for(var i:int = 0; i<rayons.length; i++){
				if((rayons[i]<Borne1 || rayons[i]>Borne2))depla[i]=-depla[i]
				rayons[i]+=depla[i]
			}
			AfficherRayons()
		}
		public function Pause(){
			this.removeEventListener(Event.ENTER_FRAME, eFrame)
		}
		public function Play(){
			this.addEventListener(Event.ENTER_FRAME, eFrame)
		}
	}
	
}




