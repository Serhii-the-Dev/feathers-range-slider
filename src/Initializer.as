package
{
	import com.junkbyte.console.Cc;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.Capabilities;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	/**
	 * ...
	 * @author Serg de Adelantado
	 */
	public final class Initializer
	{
		static public function Start(AStage:Stage):void
		{
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			ApplyStageMode(AStage);
			var vWindows:Boolean = Capabilities.manufacturer.indexOf('Windows') != -1;
			SetupConsole(AStage);
		}
		
		static private function ApplyStageMode(AStage:Stage, AScale:String = StageScaleMode.NO_SCALE, AAlign:String = StageAlign.TOP_LEFT):void
		{
			AStage.scaleMode = AScale;
			AStage.align = AAlign;
		}
		
		static private function SetupConsole(AStage:Stage):void
		{
			Cc.config.style.backgroundAlpha = 0.8;
			Cc.config.style.topMenu = false;
			Cc.startOnStage(AStage, "`");
			Cc.width = AStage.stageWidth;
			Cc.height = 300;
			Cc.fpsMonitor = true;
			Cc.memoryMonitor = true;
			Cc.commandLine = true;
			Cc.visible = false;
			Cc.config.commandLineAllowed = true;
			Cc.addSlashCommand('hide', HideConsole);
			AStage.addEventListener(Event.RESIZE, OnStageResize);
		}
		
		static private function HideConsole():void
		{
			Cc.log('Hidding console...');
			Cc.visible = false;
		}
		
		static private function OnStageResize(e:Event):void
		{
			Cc.width = Stage(e.target).stageWidth;
		}
	}
}