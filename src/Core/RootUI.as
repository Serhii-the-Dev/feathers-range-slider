package Core
{
	import com.junkbyte.console.Cc;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Radio;
	import feathers.controls.RangeSlider;
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	import feathers.core.ToggleGroup;
	import feathers.layout.VerticalLayout;
	import feathers.system.DeviceCapabilities;
	import feathers.themes.MetalWorksMobileTheme;
	import feathers.themes.MetalWorksMobileThemeExtended;
	import flash.events.FocusEvent;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Serg de Adelantado
	 */
	public class RootUI extends Screen
	{
		private var FCurrentTheme:MetalWorksMobileTheme;
		private var FRangeSlider:RangeSlider;
		private var FModes:ToggleGroup;
		private var FMinimum:TextInput;
		private var FMaximum:TextInput;
		private var FTextWidth:Number;
		private var FTextGap:Number;
		private var FRadioContainer:LayoutGroup;
		
		public function RootUI()
		{
			DeviceCapabilities.dpi = 250;
			
			FCurrentTheme = new MetalWorksMobileThemeExtended(this);
			
			const vRadioLayout:VerticalLayout = new VerticalLayout();
			vRadioLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			vRadioLayout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			vRadioLayout.gap = 32 * dpiScale;
			
			FRadioContainer = new LayoutGroup();
			FRadioContainer.layout = vRadioLayout;
			addChild(FRadioContainer);
			
			FModes = new ToggleGroup();
			
			var radio1:Radio = new Radio();
			radio1.label = "Free mode";
			radio1.toggleGroup = FModes;
			FRadioContainer.addChild(radio1);
			
			var radio2:Radio = new Radio();
			radio2.label = "Push mode";
			radio2.toggleGroup = FModes;
			FRadioContainer.addChild(radio2);
			
			var radio3:Radio = new Radio();
			radio3.label = "Lock mode";
			radio3.toggleGroup = FModes;
			FRadioContainer.addChild(radio3);
			
			FModes.addEventListener(Event.CHANGE, OnModeChange);
			
			FTextWidth = 70 * dpiScale;
			FTextGap = 10 * dpiScale;
			FMinimum = new TextInput();
			FMaximum = new TextInput();			
			FMinimum.text = '50';
			FMaximum.text = '20';
			addChild(FMinimum);
			addChild(FMaximum);
			FMinimum.width = FMaximum.width = FTextWidth;
			FMinimum.restrict = FMaximum.restrict = '0-9';
			FMinimum.maxChars = FMaximum.maxChars = 3;
			FMinimum.addEventListener("focusOut", OnInputFocusOut);
			FMaximum.addEventListener("focusOut", OnInputFocusOut);
			
			FRangeSlider = new RangeSlider();
			FRangeSlider.addEventListener(Event.CHANGE, OnSliderChange);
			FRangeSlider.maximum = 100;
			FRangeSlider.minimum = 0;
			FRangeSlider.max = 50;
			FRangeSlider.min = 20;			
			FRangeSlider.step = 0;
			FRangeSlider.mode = RangeSlider.SLIDER_MODE_PUSH;
			FModes.selectedIndex = FRangeSlider.mode;
			
			addChild(FRangeSlider);			
		}
		
		private function OnInputFocusOut(e:Event):void 
		{
			if (e.target == FMinimum)
				FRangeSlider.min = int(FMinimum.text);
			else
			{
				Cc.logch(this, 'Setting max value to ' + FMaximum.text);
				FRangeSlider.max = int(FMaximum.text);
			}
		}
		
		private function OnSliderChange(e:Event):void
		{
			FMinimum.text = Math.round(FRangeSlider.min).toString();
			FMaximum.text = Math.round(FRangeSlider.max).toString();
		}
		
		private function OnModeChange(e:Event):void
		{
			FRangeSlider.mode = FModes.selectedIndex;
		}
		
		public function Resize(AWidth:int, AHeight:int):void
		{
			FRangeSlider.validate();
			FRadioContainer.validate();
			
			var vBottom:Number = AHeight - FRangeSlider.height - AWidth * 0.05;
			
			FRadioContainer.x = (AWidth - FRadioContainer.width) / 2;
			FRadioContainer.y = (vBottom - FRadioContainer.height) / 2;
			
			FRangeSlider.width = AWidth * 0.9 - FTextWidth * 2;
			FRangeSlider.x = (AWidth - FRangeSlider.width) / 2;
			FRangeSlider.y = vBottom;
			
			FMinimum.x = FRangeSlider.x - FMinimum.width - FTextGap;
			FMaximum.x = FRangeSlider.x + FRangeSlider.width + FTextGap;
			FMinimum.y = FMaximum.y = FRangeSlider.y;
		}
	}
}