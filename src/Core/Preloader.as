package Core
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author Serg de Adelantado
	 */
	public class Preloader extends MovieClip
	{
		private var FProgress:TextField;
		
		public function Preloader()
		{
			if (stage)
				OnAddedToStage();
			else
				addEventListener(Event.ADDED_TO_STAGE, OnAddedToStage);
		}
		
		private function OnAddedToStage(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, OnAddedToStage);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			var vFormat:TextFormat = new TextFormat('Calibri', 32);
			vFormat.align = TextFormatAlign.CENTER;
			
			FProgress = new TextField();
			FProgress.defaultTextFormat = vFormat;
			FProgress.text = 'Loaded: 0%';
			FProgress.selectable = false;
			FProgress.width = stage.stageWidth;
			FProgress.textColor = 0xFFFFFF;
			addChild(FProgress);
			
			addEventListener(Event.ENTER_FRAME, OnEnterFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, OnProgress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, OnIOError);
			
			stage.addEventListener(Event.RESIZE, OnStageResize);
			OnStageResize();
		}
		
		private function OnStageResize(e:Event = null):void
		{
			if (FProgress)
			{
				FProgress.width = stage.stageWidth;
				FProgress.y = (stage.stageHeight - FProgress.height) / 2;
			}
		}
		
		private function OnIOError(e:IOErrorEvent):void
		{
			FProgress.selectable = true;
			FProgress.textColor = 0xBD2024;
			FProgress.text = 'Error: ' + e.text;
		}
		
		private function OnProgress(e:ProgressEvent):void
		{
			FProgress.text = 'Loaded: ' + Math.round(100 * e.bytesLoaded / e.bytesTotal) + '%';
		}
		
		private function OnEnterFrame(e:Event):void
		{
			if (currentFrame == totalFrames)
			{
				stop();
				Complete();
			}
		}
		
		private function Complete():void
		{
			removeEventListener(Event.ENTER_FRAME, OnEnterFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, OnProgress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, OnIOError);
			stage.removeEventListener(Event.RESIZE, OnStageResize);
			
			removeChild(FProgress);
			
			Start();
		}
		
		private function Start():void
		{
			var vRoot:Class = getDefinitionByName("Main") as Class;
			addChild(new vRoot() as DisplayObject);
		}
	}
}