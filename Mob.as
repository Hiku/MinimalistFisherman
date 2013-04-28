package  {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.media.SoundChannel;
	
	
	public class Mob extends MovieClip {
		var Barre:ViePoisson;
		var vieMax:int;
		var vie:int;
		var speedX:Number;
		var speedY:Number;
		var savon:Number;
		var bspeedX:Number;
		var bspeedY:Number;
		var _root:Object;
		var vuJoueur:Boolean;
		var Attaque:Boolean;
		var Sens:int;
		var TmpsSens:int;
		var Vision:int;
		var Deg:int;
		var Tar:Point;
		var Bouffe:int;
		
		public function Mob(num:int,Att:Boolean,spX:Number,spY:Number,sav:Number,vieM:int,vision:int,degats:int,bouf:int) {
			Bouffe = bouf
			Tar = new Point(Math.random()*550,Math.random()*400)
			Deg = degats;
			Vision = vision;
			TmpsSens = 10;
			Sens = Math.random()<0.5?-TmpsSens:0;
			vuJoueur = false;
			gotoAndStop(num)
			Attaque = Att;
			bspeedX = spX;
			bspeedY = spY;
			savon = sav
			vieMax = vieM;
			vie = vieMax;
			speedX=0;
			speedY=0;
			addEventListener(Event.ENTER_FRAME,eFrame)
			addEventListener(Event.ADDED_TO_STAGE,beginClass)
		}
		function Dist(a:Object){
			return Math.pow(Math.pow(a.x-x,2)+Math.pow(a.y-y,2),0.5)
		}
		function eFrame(e:Event){
			var angle:Number;
			if(vuJoueur){
				angle=Math.atan2(_root.jeu.perso.y - this.y,_root.jeu.perso.x - this.x);
				if(Attaque){
					speedX += Math.cos(angle) * bspeedX;
					speedY += Math.sin(angle) * bspeedY;
					speedX*=savon
					speedY*=savon
					scaleX = _root.jeu.perso.x - this.x<0?1:-1
				} else {
					speedX -= Math.cos(angle) * bspeedX;
					speedY -= Math.sin(angle) * bspeedY;
					speedX*=savon
					speedY*=savon
					scaleX = _root.jeu.perso.x - this.x<0?-1:1
				}
			} else {
				angle=Math.atan2(Tar.y - this.y,Tar.x - this.x);
				y--;
				Tar.y--;
				speedX += Math.cos(angle) * bspeedX;
				speedY += Math.sin(angle) * bspeedY;
				speedX*=savon
				speedY*=savon
				scaleX = Tar.x - this.x<0?1:-1
				if(Dist(Tar)<10)Tar = new Point(this.x + Math.random()*300-150, this.y + Math.random()*100-50)
				if(((_root.jeu.perso.x<x)==(speedX<0))&&Dist(_root.jeu.perso)<Vision){
					vuJoueur=true;
				}
			}
			x+=speedX
			y+=speedY
			if(_root.jeu.perso.Pec.hitTestObject(this)&&Attaque){
				_root.jeu.perso.BaisserVie(Deg);
				_root.jeu.CreerSang(_root.jeu.perso);
				var snd:Hurt = new Hurt();
				var channel:SoundChannel;
				channel = snd.play();

			}
		}
		function Degats(i:int){
			vie-=i;
			if(vie<0)Death();
			_root.jeu.CreerSang(this);
		}
		function Death(){
			_root.score+=Bouffe;
			var Cad:Cadavre = new Cadavre(currentFrame,x,y)
			_root.jeu.addChild(Cad)
			for(var i:int=0; i<_root.jeu.Poissons.length;i++){
				if(_root.jeu.Poissons[i]==this)_root.jeu.Poissons.splice(i,1)
			}

			if(this.parent!=null){
				this.removeEventListener(Event.ENTER_FRAME,eFrame)
				this.parent.removeChild(this)
			}

		}
		function beginClass(e:Event){
			_root = MovieClip(root)
			_root.jeu.Poissons.push(this)
			Barre = new ViePoisson(this,-10)
			addChild(Barre)
		}
		
		public function Pause(){
			this.removeEventListener(Event.ENTER_FRAME, eFrame)
		}
		
		public function Play(){
			this.addEventListener(Event.ENTER_FRAME, eFrame)
		}

	}
	
}
