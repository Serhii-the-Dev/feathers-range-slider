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
			AddRadioButton("Free mode");
			AddRadioButton("Push mode");
			AddRadioButton("Lock mode");
			FModes.addEventListener(Event.CHANGE, OnModeChange);
			
			FTextWidth = 160 * dpiScale;
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
			FRangeSlider.minimum = 1900;
			FRangeSlider.maximum = 2000;
			FRangeSlider.valueMinimum = 1940;
			FRangeSlider.valueMaximum = 1960;			
			
			FRangeSlider.mode = FModes.selectedIndex = RangeSlider.SLIDER_MODE_PUSH;
			addChild(FRangeSlider);
		}
		
		private function AddRadioButton(ALabel:String):Radio
		{
			var vResult:Radio = new Radio();
			vResult.label = ALabel;
			vResult.toggleGroup = FModes;
			FRadioContainer.addChild(vResult);
			return vResult;
		}
		
		private function OnInputFocusOut(e:Event):void
		{
			if (e.target == FMinimum)
				FRangeSlider.valueMinimum = int(FMinimum.text);
			else
			{
				Cc.logch(this, 'Setting max value to ' + FMaximum.text);
				FRangeSlider.valueMaximum = int(FMaximum.text);
			}
		}
		
		private function OnSliderChange(e:Event):void
		{
			FMinimum.text = (FRangeSlider.valueMinimum).toFixed(6);
			FMaximum.text = (FRangeSlider.valueMaximum).toFixed(6);
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