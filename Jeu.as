package  {
	import flash.geom.Point;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.display.MovieClip;
	import flash.media.SoundChannel;
	import flash.filters.BlurFilter;

	public class Jeu extends MovieClip {
		var _root:Object;
		var Bulles:Array;
		var Poissons:Array;
		var Algues:Array;
		var Cadavres:Array;
		var Sangs:Array;
		var left:Boolean;
		var right:Boolean;
		var up:Boolean;
		var down:Boolean;
		var perso:Perso;
		var Ray:Rayons;
		var bTimer:int;
		var tmps:int;
		var pau:Boolean = false;
		var flou:Number = 0.5;
		var gameover:Boolean =false;
		var bMax:int
		var BAug:Number;
		var TempsAlgue:int;
		
								   //Vie,Degats,Bouffe,Vision,speedX,speedY,nombrePopMax,rarete,tpsMin,tpsMax
		const DataPoisson:Array = [[20,0,1,50,0.3,0.2,200,0.005,0,10000],//Petite merde
								   [80,0,10,50,0.25,0.15,12,0.005,0,10000],//Merde
								   [100,0,30,100,0.3,0.2,3,0.01,300,10000],//Croissant
								   [300,0,60,100,0.4,0.3,2,0.006,200,10000],//Grosse merde
								   [1000,0,300,50,0.2,0.1,1,0.005,700,10000],//Baleine
								   [300,3,30,100,0.6,0.5,3,0.01,500,10000],//Requin
								   [2500,5,100,100,0.5,0.4,1,0.002,1000,10000],//Lunettes de Soleil
								   [1500,15,300,100,0.8,0.6,1,0.002,1000,10000],//Scie
								   [1000,0,200,100,0.6,0.5,1,0.003,500,10000],//Raie
								   ]


		public function Jeu(BulleAug:int,ArmeAug:int,VieAug:int,RadeauAug:int){
			TempsAlgue=0
			if(BulleAug==0)BAug=1;
			if(BulleAug==1)BAug=0.5;
			if(BulleAug==2)BAug=0.25;
			if(BulleAug==3)BAug=0.15;
			bMax = 0;
			tmps=0;
			bTimer=0;
			Bulles = new Array()
			Poissons = new Array()
			Sangs = new Array()
			Algues = new Array();
			Cadavres = new Array();
			left = false;
			right = false;
			up = false;
			down = false;
			perso = new Perso(ArmeAug+1,VieAug)
			perso.x = 275;
			perso.y = 0;
			perso.speedY = 5
			addChild(perso)
			Ray = new Rayons(Math.PI/8,3*Math.PI/4,new Point(150,-150),50,6000)
			addChild(Ray)
			addEventListener(Event.ADDED_TO_STAGE,beginClass)
			addEventListener(Event.ENTER_FRAME,eFrame)
		}
		public function Kill(){
			removeEventListener(Event.ENTER_FRAME,Flou)
			if(this.parent!=null)this.parent.removeChild(this)
		}
		function beginClass(e:Event){
			_root = MovieClip(root)
			_root.stage.addEventListener(KeyboardEvent.KEY_DOWN, checkKeysDown);
			_root.stage.addEventListener(KeyboardEvent.KEY_UP, checkKeysUp);
			_root.JouerMusique(new Ocean(),true)
		}
		function Flou(e:Event){
			flou+=0.03;
			flou*=0.99;
			filters = new Array(new BlurFilter(flou,flou,5))
			this.alpha-=0.01;
			if(alpha<=0)_root.AffMenu(true)
		}
		function eFrame(e:Event){
			TempsAlgue--
			if(TempsAlgue<=0){
				var al:Algue = new Algue()
				addChild(al)
				TempsAlgue=Math.floor(Math.random()*200)
			}
			tmps++;
			bTimer++;
			for(var i:int = 0; i<Algues.length; i++){
				if(Algues[i].parent!=null){
					Algues[i].parent.setChildIndex(Algues[i],Algues[i].parent.numChildren-1)
				}
				
			}
			setChildIndex(Ray,numChildren-1)
			_root.setChildIndex(_root.scor,_root.numChildren-1);
			if(bTimer>bMax){
				if(BAug>Math.random()){
					bMax++;
				}
				bTimer = 0;
				var b:Bulle = new Bulle()
				b.x = Math.floor(Math.random()*550)
				b.y = 400
				addChild(b)
			}

			Scroll()
			Spawn()
		}
		function GameOver(){
			gameover = true;
			addEventListener(Event.ENTER_FRAME,Flou)
			Pause()
		}
		function CreerSang(ob:Object){
			var sang:Sang = new Sang()
			sang.x = ob.x-14+Math.random()*20-10;
			sang.y = ob.y-13+Math.random()*20-10;
			_root.jeu.addChild(sang)
			Sangs.push(sang)
		}
		function finSang(sang:MovieClip){
			for(var i:int = 0; i<Sangs.length; i++){
				if(sang==Sangs[i])Sangs.splice(i,1)
			}
			removeChild(sang)
		}
		function Spawn(){
			
		//Vie,Degats,Bouffe,Vision,speedX,speedY,nombrePopMax,rarete,tpsMin,tpsMax
			for(var i:int = 0; i<DataPoisson.length; i++){
				if(DataPoisson[i][7]>Math.random()&&DataPoisson[i][8]<tmps&&DataPoisson[i][9]>tmps){
					var X:int=0;
					var Y:int=0;
					while(X<=550&&X>=0&&Y<=400){
						X = Math.floor(-100+Math.random()*750)
						Y = Math.floor(0+Math.random()*500)
					}
					for(var j:int = 0; j<Math.floor(Math.random()*DataPoisson[i][6])+1;j++){
						var mob:Mob = new Mob(i+1,DataPoisson[i][1]>0,DataPoisson[i][4]*(Math.random()+1),DataPoisson[i][5]*(Math.random()+1),0.5,DataPoisson[i][0],DataPoisson[i][3],DataPoisson[i][1],DataPoisson[i][2])
						mob.x = X+Math.floor(Math.random()*50-25)
						mob.y = Y+Math.floor(Math.random()*50-25)
						addChild(mob)
					}
				}
			}
			
		}
		
		function Scroll(){
			Ray.ptBase.y-=0.1;
		}
		
		function checkKeysDown(event:KeyboardEvent):void{
			if(event.keyCode == 65){
				left = true;
			}
			if(event.keyCode == 87){
				up = true;
			}
			if(event.keyCode == 68){
				right = true;
			}
			if(event.keyCode == 83){
				down = true;
			}		
			if(event.keyCode == 80){
				pau=!pau;
				if(pau)Pause()
				if(!pau)Play()
			}		
			if(event.keyCode == 32){
				perso.ArmeOn()
			}		
		}
		function checkKeysUp(event:KeyboardEvent):void{
			if(event.keyCode == 81){
				left = false;
			}
			if(event.keyCode == 90){
				up = false;
			}
			if(event.keyCode == 68){
				right = false;
			}
			if(event.keyCode == 83){
				down = false;
			}
			if(event.keyCode == 32){
				perso.ArmeOff()
			}
		}
		
		function Pause(){
			perso.Pause();
			for(var i:int=0; i<Bulles.length; i++){
				Bulles[i].Pause();
			}
			for(i=0; i<Poissons.length; i++){
				Poissons[i].Pause();
			}
			for(i=0; i<Sangs.length; i++){
				Sangs[i].stop();
			}
			for(i=0; i<Algues.length; i++){
				Algues[i].Pause();
			}
			for(i=0; i<Cadavres.length; i++){
				Cadavres[i].Pause();
			}
			Ray.Pause();
			removeEventListener(Event.ENTER_FRAME,eFrame)
		}
		function Play(){
			perso.Play();
			for(var i:int=0; i<Bulles.length; i++){
				Bulles[i].Play();
			}
			for(i=0; i<Poissons.length; i++){
				Poissons[i].Play();
			}
			for(i=0; i<Sangs.length; i++){
				Sangs[i].play();
			}
			for(i=0; i<Algues.length; i++){
				Algues[i].Play();
			}
			for(i=0; i<Cadavres.length; i++){
				Cadavres[i].Play();
			}

			Ray.Play();
			addEventListener(Event.ENTER_FRAME,eFrame)

		}

	}
	
}

