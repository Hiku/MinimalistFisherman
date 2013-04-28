package  {
	
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.media.SoundChannel;
	
	
	public class Perso extends MovieClip {
		private var _root:Object;
		var k:int;
		var f:int;
		var fps:int;
		var speedX:Number;
		var speedY:Number;
		var Pec:Pecheur;
		const speed:Number = 0.5;
		const savon:Number = 0.95;
		var vie:int;
		var vieMax:int;
		var arme:Arme;
		var attacking:Boolean =false;
		var empArme:Point;
		var numArme:int;
		var degArme:int;
		
		public function Perso(arm:int, vieAug:int) {
			stop()
			numArme=arm;
			degArme=Math.pow(numArme,2)*2+1;
			empArme = new Point(-3,11)
			k=0;
			f=1;
			speedX = 0;
			speedY = 0;
			if(vieAug==0)vieMax = 300;
			if(vieAug==1)vieMax = 500;
			if(vieAug==2)vieMax = 1000;
			//vieMax = 0;
			vie = vieMax;
			this.addEventListener(Event.ENTER_FRAME,eFrame)
			this.addEventListener(Event.ADDED_TO_STAGE,beginClass)
		}
		function ArmeOn(){
			Pec.gotoAndStop(4)
			attacking = true;
			arme.visible = attacking
		}
		function ArmeOff(){
			attacking = false;
			arme.visible = attacking
			Pec.gotoAndStop(f)
		}
		function Pause(){
			this.removeEventListener(Event.ENTER_FRAME,eFrame)
		}
		function Play(){
			this.addEventListener(Event.ENTER_FRAME,eFrame)
		}
		function beginClass(e:Event){
			_root = MovieClip(root)
			arme = new Arme()
			addChild(arme)
			Pec = new Pecheur
			addChild(Pec)
			arme.gotoAndStop(numArme)
			arme.x = empArme.x;
			arme.y = empArme.y;
			arme.stop()
			arme.visible = attacking
		}
		function eFrame(e:Event){
			BaisserVie(1)
			UpdateRender()
			Deplacer()
			if(attacking)VerifPoissons()
			VerifBulles()
			arme.visible = attacking
		}
		function VerifBulles(){
			for(var i:int = 0; i<_root.jeu.Bulles.length; i++){
				if(Pec.hitTestObject(_root.jeu.Bulles[i])&&!_root.jeu.Bulles[i].repris){
					MonterVie(Math.round(Math.pow(_root.jeu.Bulles[i].taille,3)/2)+5);
					_root.jeu.Bulles[i].Exploser()
					var snd:BulleSnd = new BulleSnd();
					var channel:SoundChannel;
					channel = snd.play();
				}
			}
		}
		function VerifPoissons(){
			for(var i:int = 0; i<_root.jeu.Poissons.length; i++){
				if(arme.hitTestObject(_root.jeu.Poissons[i])){
					var deg:int = (speedY+1)*degArme;
					if(deg>degArme){_root.jeu.Poissons[i].Degats(deg)}
					else{_root.jeu.Poissons[i].Degats(degArme)}
					var snd:Hurt = new Hurt();
					var channel:SoundChannel;
					channel = snd.play();
				}
			}
		}

		function Deplacer(){
			if(!attacking){
				if(_root.jeu.left)speedX-=speed;
				if(_root.jeu.right)speedX+=speed;
				if(_root.jeu.up)speedY-=speed;
				if(_root.jeu.down)speedY+=speed;
			}
			speedX*=savon;
			speedY*=savon;
			if(x+speedX>550||x+speedX<0)speedX=0;
			if(y+speedY>400||y+speedY<0)speedY=0;
			x+=speedX;
			y+=speedY;
			if(Math.abs(speedX)<0.1)x=Math.round(x)
			if(Math.abs(speedY)<0.1)y=Math.round(y)
		}
		function UpdateRender(){
			if(!attacking){k++
				fps = 5;
				if(_root.jeu.up)fps /=5
				if(_root.jeu.down)fps *=5
				if(k>24/fps){
					k=0;
					f++;
					if(f>3)f-=3;
					Pec.gotoAndStop(f)
				}
			}
		}
		function BaisserVie(k:int){
			vie-=k;
			if(vie<0){
				vie=0
				_root.jeu.GameOver();
			}
		}
		function MonterVie(k:int){
			vie+=k;
			if(vie>vieMax)vie=vieMax
		}
	}
}

