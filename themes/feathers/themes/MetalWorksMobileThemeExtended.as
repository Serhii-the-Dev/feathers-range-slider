package feathers.themes
{
	import feathers.controls.Button;
	import feathers.controls.RangeSlider;
	import feathers.skins.SmartDisplayObjectStateValueSelector;
	import feathers.themes.MetalWorksMobileTheme;
	import starling.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author Serg de Adelantado
	 */
	public class MetalWorksMobileThemeExtended extends MetalWorksMobileTheme
	{
		public function MetalWorksMobileThemeExtended(container:DisplayObjectContainer = null, scaleToDPI:Boolean = true)
		{
			super(container, scaleToDPI);
		}
		
		override protected function setInitializers():void
		{
			super.setInitializers();
			setInitializerForClass(RangeSlider, rangeSliderInitializer);
			setInitializerForClass(Button, dangerButtonInitializer, RangeSlider.DEFAULT_CHILD_NAME_MINIMUM_THUMB);			
		}
		
		protected function rangeSliderInitializer(slider:RangeSlider):void
		{
			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = backgroundSkinTextures;
			skinSelector.setValueForState(backgroundDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties = {textureScale: this.scale};
			
			skinSelector.displayObjectProperties.width = 210 * scale;
			skinSelector.displayObjectProperties.height = 60 * scale;
			
			slider.backgroundProperties.stateToSkinFunction = skinSelector.updateValue;
		}
	}
}