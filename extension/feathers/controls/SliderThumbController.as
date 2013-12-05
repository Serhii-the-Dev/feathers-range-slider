package feathers.controls
{
	import feathers.core.FeathersControl;
	import feathers.events.FeathersEventType;
	import flash.geom.Point;
	import starling.display.DisplayObject;
	import starling.events.EventDispatcher;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author Serg de Adelantado
	 */
	[Event(name='beginInteraction',type='starling.events.Event')]
	[Event(name='endInteraction',type='starling.events.Event')]
	
	public class SliderThumbController extends EventDispatcher
	{
		private var _thumb:DisplayObject;
		private var _slider:FeathersControl;
		private var _touchPointID:int;
		private var _value:Number;
		private var _touchStart:Point;
		private var _thumbStart:Point;
		private var _helperPoint:Point;
		private var _isDragging:Boolean;
		
		public function SliderThumbController()
		{
			_touchStart = new Point();
			_thumbStart = new Point();
			_helperPoint = new Point();
		}
		
		private function onThumbTouch(e:TouchEvent):void
		{
			if (!slider || _slider.isEnabled)
			{
				_touchPointID = -1;
				return;
			}
			if (_touchPointID >= 0)
			{
				touch = e.getTouch(_thumb, null, _touchPointID);
				if (!touch)
					return;				
				if (touch.phase == TouchPhase.MOVED)
				{
					touch.getLocation(this, _helperPoint);					
					//TODO: value calculaion
				}
				else if (touch.phase == TouchPhase.ENDED)
				{					
					_touchPointID = -1;
					_isDragging = false;
					dispatchEventWith(FeathersEventType.END_INTERACTION);
				}
			}
			else
			{
				touch = e.getTouch(_thumb, TouchPhase.BEGAN);
				if (!touch)
					return;				
				touch.getLocation(this, _helperPoint);				
				_touchPointID = touch.id;
				_touchStart.setTo(_helperPoint.x, _helperPoint.y);
				_thumbStart.setTo(_thumb.x, _thumb.y);
				_isDragging = true;				
				dispatchEventWith(FeathersEventType.BEGIN_INTERACTION);
			}
		}
		
		public function get thumb():DisplayObject
		{
			return _thumb;
		}
		
		public function set thumb(value:DisplayObject):void
		{
			if (_thumb)
				_thumb.removeEventListener(TouchEvent.TOUCH, onThumbTouch);
			
			_thumb = value;
			if (_thumb)
				_thumb.addEventListener(TouchEvent.TOUCH, onThumbTouch);
		}
		
		public function get slider():FeathersControl
		{
			return _slider;
		}
		
		public function set slider(value:FeathersControl):void
		{
			_slider = value;
		}
	}
}