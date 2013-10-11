package journey 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.utils.getDefinitionByName
	
	public class Preloader extends MovieClip 
	{
		
		private var progressBar:Sprite;
		
		public function Preloader() 
		{
			// you know what, I have no idea what the purpose of this block is
			if (stage) {
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT
			}
			
			// set up preloader callbacks
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			
			// set up progress bar box
			progressBar = new Sprite();
			// draw box
			progressBar.graphics.lineStyle(2, 0x444444);
			progressBar.graphics.drawRect(0, 0, 320, 20);
			// position box
			progressBar.x = (stage.stageWidth / 2) - (progressBar.width / 2);
			progressBar.y = (stage.stageHeight / 2) - (progressBar.height / 2);
			addChild(progressBar);
		}
		
		private function checkFrame(e:Event):void
		{
			// if we have finished loading, begin cleanup
			if (currentFrame == totalFrames)
			{
				stop();
				loadingFinished();
			}
		}
		
		private function progress(e:ProgressEvent):void
		{
			var progress:Number = e.bytesLoaded / e.bytesTotal;
			// draw the actual progress bar
			progressBar.graphics.lineStyle(0);
			progressBar.graphics.beginFill(0x666666);
			progressBar.graphics.drawRect(2, 2, 316 * progress, 16);
			progressBar.graphics.endFill();
		}
		
		private function loadingFinished():void
		{
			// disconnect preloader callbacks
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			
			// hide progress bar
			removeChild(progressBar);
			progressBar = null;
			
			// start main program
			startup();
		}
		
		private function startup():void
		{
			var mainClass:Class = getDefinitionByName("journey.Main") as Class;
			addChild(new mainClass() as DisplayObject);
		}
		
	}

}
