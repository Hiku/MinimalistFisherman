package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class BulleBD extends MovieClip {
		var Bull:Sprite;
		var t:TextField;
		
		
		public function BulleBD(X:int,Y:int,Text:String) {
			Bull = new Sprite()
			addChild(Bull)
			t = new TextField()
			t.text = Text;
			t.x = 20
			t.y = 360
			t.width = 550
			t.selectable = false;
			var format:TextFormat = new TextFormat();
			format.font = (new Calibri()).fontName;
			format.size = 16
			t.setTextFormat(format)
			addChild(t)
			CreerBulle(X,Y)
		}
		function CreerBulle(X:int,Y:int){
			Bull.graphics.beginFill(0xFFFFFF)
			Bull.graphics.lineStyle(1,0)
			Bull.graphics.moveTo(X-6,350)
			Bull.graphics.lineTo(X,Y)
			Bull.graphics.lineTo(X+6,350)
			Bull.graphics.lineTo(540,350)
			Bull.graphics.lineTo(540,390)
			Bull.graphics.lineTo(10,390)
			Bull.graphics.lineTo(10,350)
			Bull.graphics.lineTo(X-6,350)
			Bull.graphics.endFill()
		}
	}
	
}
