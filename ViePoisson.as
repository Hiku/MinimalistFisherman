package  {
	import flash.display.MovieClip;
	import flash.events.Event;

	public class ViePoisson extends MovieClip {
		var poisson:MovieClip;
		const taille:int = 8;
		public function ViePoisson(p:MovieClip,Y) {
			y=Y;
			poisson = p;
			addEventListener(Event.ENTER_FRAME,eFrame)
		}
		function Tracer(){
			graphics.clear()
			graphics.beginFill(0)
			graphics.drawRect(-taille-1,-3,2*taille+1,6)
			graphics.endFill()
			graphics.beginFill(Couleur(poisson.vie/poisson.vieMax))
			graphics.drawRect(-taille,-2,2*taille*poisson.vie/poisson.vieMax,4)
			graphics.endFill()
		}
		function eFrame(e:Event){
			if(poisson.vie!=poisson.vieMax)Tracer()
			if(poisson.scaleX==-1)this.scaleX=-1
		}
		
		function Couleur(part:Number):uint{
			var rouge:int = 255
			var vert:int = 255
			if(part>0.5){
				rouge-=(part-0.5)*255
			} else {
				vert-=(0.5-part)*255
			}
			return rouge*256*256+vert*256;
		}

	}
	
}
