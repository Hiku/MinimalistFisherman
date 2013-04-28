package  {
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class Algue extends MovieClip {
		const distMin:int = 8
		const distMax:int = 30
		const RangMaxMin:int = 7
		const RangMaxMax:int = 13
		var color:uint;
		var epaisseur:int;
		var _root:Object
		var pla:Boolean = true;
		
		public function Algue(){
			color = Math.random()*256*256*256;
			epaisseur=Math.round(Math.random()*3)+1
			var cote:Boolean = Math.random()<0.5;
			var ang:Number = Math.random()*Math.PI
			if(cote)ang+=Math.PI;
			var r:int = Math.floor(Math.random()*(RangMaxMax-RangMaxMin)+RangMaxMin)
			Render(cote?550:0,800,ang,0,r)
			addEventListener(Event.ENTER_FRAME,eFrame)
			this.addEventListener(Event.ADDED_TO_STAGE,beginClass)
		}
		function beginClass(e:Event){
			_root = MovieClip(root)
			_root.jeu.Algues.push(this)
		}
		function Render(X:int,Y:int,angle:Number,rang:int,rangMax:int){
			for(var i:int = 0; i<(rangMax-rang)/rangMax*Math.random()*3;i++){
				var dist:int = Math.floor(Math.random()*(distMax-distMin)+distMin)
				var newAngle:Number = angle+(Math.random()-0.5)
				var newX:int = X+Math.floor(Math.cos(newAngle)*dist)
				var newY:int = Y+Math.floor(Math.sin(newAngle)*dist)
				graphics.lineStyle(2,color,0.5)
				graphics.moveTo(X,Y)
				graphics.lineTo(newX,newY)
				Render(newX,newY,newAngle,rang+1,rangMax)
			}
		}
		function eFrame(e:Event){
			if(pla)y--;
			if(y<-1200&&this.parent!=null){
				for(var i:int = 0; i<_root.jeu.Algues.length; i++){
					if(_root.jeu.Algues[i]==this)_root.jeu.Algues.splice(i,1)
				}
				this.parent.removeChild(this)
			}
		}
		function Pause(){
			pla=false;
		}
		function Play(){
			pla=true;
		}
	}
	
}
