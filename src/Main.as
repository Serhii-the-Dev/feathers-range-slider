package
{
	import Core.RootUI;
	import flash.display.Sprite;
	import flash.events.Event;
	import starling.core.Starling;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Serg de Adelantado
	 */
	[Frame(factoryClass="Core.Preloader")]
	
	public class Main extends Sprite
	{
		private var FStarling:Starling;
		private var FRootUI:RootUI;
		
		public function Main():void
		{
			if (!stage)
				addEventListener(flash.events.Event.ADDED_TO_STAGE, OnAddedToStage);
			else
				OnAddedToStage();
		
		}
		
		private function OnAddedToStage(e:Object = null):void
		{
			removeEventListener(flash.events.Event.ADDED_TO_STAGE, OnAddedToStage);
			
			Initializer.Start(stage);
			
			Starling.handleLostContext = true;
			Starling.multitouchEnabled = true;
			
			FStarling = new Starling(RootUI, stage);
			FStarling.addEventListener(starling.events.Event.ROOT_CREATED, OnStarlingRootCreated);
			FStarling.addEventListener(starling.events.Event.CONTEXT3D_CREATE, OnContext3DCreated);
			FStarling.enableErrorChecking = false;
			FStarling.showStats = false;
			FStarling.start();
		}
		
		private function OnContext3DCreated(e:Object):void
		{
			ResizeStarling(stage.stageWidth, stage.stageHeight);
		}
		
		private function OnStarlingRootCreated(e:Object):void
		{
			FRootUI = RootUI(FStarling.root);
			stage.addEventListener(flash.events.Event.RESIZE, OnStageResize);
			OnStageResize();
		}
		
		private function OnStageResize(e:Object = null):void
		{
			var vWidth:int = stage.stageWidth;
			var vHeight:int = stage.stageHeight;
			ResizeStarling(vWidth, vHeight);
			if (FRootUI)
				FRootUI.Resize(vWidth, vHeight);
		}
		
		private function ResizeStarling(AWidth:int, AHeight:int):void
		{
			FStarling.stage.stageWidth = AWidth;
			FStarling.stage.stageHeight = AHeight;
			FStarling.viewPort.width = AWidth;
			FStarling.viewPort.height = AHeight;
		}
	}
}