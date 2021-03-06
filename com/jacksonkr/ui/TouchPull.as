﻿package com.jacksonkr.ui {
	import flash.events.EventDispatcher;
	import flash.events.TouchEvent;
	import flash.display.DisplayObject;
	import com.jacksonkr.events.TouchPullEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	public final class TouchPull extends EventDispatcher {
		/**
		 * Stores the TouchEvent that is passed to the constructer
		 */
		private var _begin:TouchEvent;
		private var _end:TouchEvent;
		/**
		 * The radians of the direction the finger is being pulled
		 */
		private var _radians:Number = 0;
		/**
		 * The distance the finger has been pull from the starting spot
		 */
		private var _distance:Number = 0;
		private var _start_time:int = 0;
		
		public function TouchPull(event:TouchEvent) {
			super();
			
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			this._begin = event;
			this._start_time = getTimer();
			
			this._begin.target.stage.addEventListener(TouchEvent.TOUCH_MOVE, this.touchMoveHandler);
			this._begin.target.stage.addEventListener(TouchEvent.TOUCH_END, this.touchEndHandler);
			
			//this._begin.target.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.touchMoveHandler);
			//this._begin.target.stage.addEventListener(MouseEvent.MOUSE_UP, this.touchEndHandler);
		}
		
		private function touchMoveHandler(event:TouchEvent):void {
			if(this._begin.touchPointID == event.touchPointID) {
				// rads
				var r:Number = Math.atan2(event.localY - this._begin.localY, event.localX - this._begin.localX);
				if(r < 0) r += Math.PI * 2; // makes the circle 0,180;180,360 instead of 0,-180;-180,0
				
				switch(true) {
					case this.distance - r > Math.PI / 2:
						this.mainDispatch(TouchPullEvent.ANALOG_DIRECTION_CHANGE);
					case this.distance - r > Math.PI / 4:
						this.mainDispatch(TouchPullEvent.DIGITAL_DIRECTION_CHANGE);
					default:
						this.mainDispatch(TouchPullEvent.DIRECTION_CHANGE);
					break;
				}
				
				// distance a^2 + b^2 = c^2
				var d:Number = Math.sqrt(Math.pow(this._begin.localX - event.localX, 2) + Math.pow(this._begin.localY - event.localY, 2));
				
				// has to be done after speed is calculated
				this._radians = r;
				this._distance = d;
				
				this.mainDispatch(Event.CHANGE);
			}
		}
		private function touchEndHandler(event:TouchEvent):void {
			if(this._begin.touchPointID == event.touchPointID) {
				this._end = event;
				
				this._begin.target.stage.removeEventListener(TouchEvent.TOUCH_MOVE, this.touchMoveHandler);
				this._begin.target.stage.removeEventListener(TouchEvent.TOUCH_END, this.touchEndHandler);
				
				//this._begin.target.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.touchMoveHandler);
				//this._begin.target.stage.removeEventListener(MouseEvent.MOUSE_UP, this.touchEndHandler);
				
				this.mainDispatch(Event.COMPLETE);
			}
		}
		private function mainDispatch(type:String) {
			this.dispatchEvent(new TouchPullEvent(type, false, true, this.begin, this.end, this.radians, this.direction, this.distance, this.time, this.velocity));
		}
		
		public function get begin():TouchEvent {
			return this._begin;
		}
		public function get end():TouchEvent {
			return this._end;
		}
		public function get radians():Number {
			return this._radians;
		}
		public function get distance():Number {
			return Number(this._distance.toFixed(2));
		}
		public function get time():Number {
			return getTimer() - this._start_time;
		}
		public function get velocity():Number {
			return this.distance / this.time;
		}
		public function get direction():String {
			var arr:Array = [TouchPullEvent.RIGHT, 
							 TouchPullEvent.DOWN_RIGHT, 
							 TouchPullEvent.DOWN, 
							 TouchPullEvent.DOWN_LEFT, 
							 TouchPullEvent.LEFT, 
							 TouchPullEvent.UP_LEFT, 
							 TouchPullEvent.UP, 
							 TouchPullEvent.UP_RIGHT];
			return arr[Math.floor(((this.radians + Math.PI * 0.125) % (Math.PI * 2)) / (Math.PI / 4))];
		}
	}
}
