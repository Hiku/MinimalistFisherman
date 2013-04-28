package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Shape;

	public class BarreVie extends MovieClip {
		var contours:Shape;
		var interieur:Shape;
		var vie:int;
		var vieMax:int;
		var qualite:int;
		var taille:int;
		var _root:Object;
		
		public function BarreVie() {
			contours = new Shape()
			interieur = new Shape()
			vie = 0;
			vieMax = 50;
			qualite = 50;
			taille = 50;
			TracerContours()
			addEventListener(Event.ENTER_FRAME,eFrame)
			addEventListener(Event.ADDED_TO_STAGE,beginClass)
		}
		function beginClass(e:Event){
			_root = MovieClip(root)
			addChild(contours)
			addChild(interieur)
		}
		function TracerContours(){
			contours.graphics.beginFill(0xFFFFFF)
			contours.graphics.lineStyle(2,0)
			contours.graphics.moveTo(taille/3,0)
			for(var i:int = 0; i<=qualite; i++){
				contours.graphics.lineTo(Math.cos(i/qualite*Math.PI)*taille, Math.sin(i/qualite*Math.PI)*taille)
			}
			for(i = qualite; i>=0; i--){
				contours.graphics.lineTo(Math.cos(i/qualite*Math.PI)*taille/3, Math.sin(i/qualite*Math.PI)*taille/3)
			}
			contours.graphics.endFill()
		}
		function TracerInterieur(){
			interieur.graphics.clear()
			interieur.graphics.beginFill(Couleur(vie/vieMax))
			interieur.graphics.moveTo(0,0)
			for(var i:int = 0; i<=qualite; i++){
				interieur.graphics.lineTo(-Math.cos(i/qualite*Math.PI*vie/vieMax)*taille, Math.sin(i/qualite*Math.PI*vie/vieMax)*taille)
			}
			for(i = qualite; i>=0; i--){
				interieur.graphics.lineTo(-Math.cos(i/qualite*Math.PI*vie/vieMax)*taille/3, Math.sin(i/qualite*Math.PI*vie/vieMax)*taille/3)
			}
		
			interieur.graphics.endFill()
		}
		function eFrame(e:Event){
			
			vie = _root.jeu.perso.vie;
			vieMax = _root.jeu.perso.vieMax;
			TracerInterieur()
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