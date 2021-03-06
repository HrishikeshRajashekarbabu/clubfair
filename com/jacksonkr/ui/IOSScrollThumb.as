﻿package com.jacksonkr.ui {
	import flash.display.Sprite;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;

	public class IOSScrollThumb extends Sprite {
		public static const MARGINS:Number = 2.0;
		public static const WIDTH:Number = 5.0;
		public static const MIN_INIT_HEIGHT:Number = 35.0;
		public static const MIN_HEIGHT:Number = 5.0;
		protected static const ALPHA_1:Number = 0.5;
		protected static const SCRUNCH_FACTOR:Number = 0.7;
		
		protected var _area:IOSScrollArea;
		protected var _type:int;
		protected var _init_x:Number;
		protected var _init_y:Number;
		protected var _alpha_id:int;
		protected var _init_height:Number;
		
		protected static const HV:Array = [WIDTH / 8, MIN_HEIGHT / 8, WIDTH / 2, MIN_HEIGHT / 2]; // height values
		
		public function IOSScrollThumb(area:IOSScrollArea, type:int) {
			this._area = area;
			this._type = type;
			
			this.alpha = 0;
			
			switch(this._type) {
				case IOSScrollArea.VERTICAL:
					this.x = this._init_x = area.width - (WIDTH + IOSScrollThumb.MARGINS);
					this.y = this._init_y = area.y + MARGINS;
					
					this.initHeight = area.height * (area.height / area.item.height);
				break;
				case IOSScrollArea.HORIZONTAL:
					this.x = this._init_x = area.x + MARGINS;
					this.y = this._init_y = area.y + (area.height - IOSScrollThumb.MARGINS);
					
					this.initHeight = area.width * (area.width / area.item.width);
					
					this.rotation = 270;
				break;
			}
		}
		
		protected function set initHeight(val:Number):void {
			if(val < MIN_INIT_HEIGHT) val = MIN_INIT_HEIGHT;
			this.height = this._init_height = val;
		}
		
		override public function set height(value:Number):void {
			if(value < MIN_HEIGHT) value = MIN_HEIGHT;
			
			this.graphics.clear();
			this.graphics.beginFill(0x000000);
			// top left
			this.graphics.moveTo(0, HV[3]);
			// top left to top center
			this.graphics.curveTo(HV[0], HV[1], HV[2], 0);
			// top center to top right
			this.graphics.curveTo(WIDTH - HV[0], HV[1], WIDTH, HV[3]);
			// top right to bottom right
			this.graphics.lineTo(WIDTH, value - HV[3]);
			// bottom right to bottom center
			this.graphics.curveTo(WIDTH - HV[0], value - HV[1], HV[2], value);
			// bottom center to bottom left
			this.graphics.curveTo(HV[0], value - HV[1], 0, value - HV[3]);
			// bottom left to top left
			this.graphics.endFill();
			
			//super.height = value;
		}
		public function set percent(val:Number):void {
			this.show();
			
			switch(this._type) {
				case IOSScrollArea.VERTICAL:
					
					if(val < 0) {
						this.height = this._init_height - (this._area.item.y - this._area.zero.y) * SCRUNCH_FACTOR;
						this.y = this._init_y;
					} else if(val > 1) {
						this.height = this._init_height + ((this._area.item.y - this._area.zero.y) + (this._area.item.height - this._area.height)) * SCRUNCH_FACTOR;
						this.y = this._init_y + this._area.height - MARGINS*2 - this.height;
					} else {
						this.height = this._init_height;
						this.y = this._init_y + (this._area.height - MARGINS*2) * val - this.height * val;
					}
				break;
				case IOSScrollArea.HORIZONTAL:
					this.rotation = 0;
					if(val < 0) {
						this.height = this._init_height - (this._area.item.x - this._area.zero.x) * SCRUNCH_FACTOR;
						this.x = this._init_x;
					} else if(val > 1) {
						this.height = this._init_height + ((this._area.item.x - this._area.zero.x) + (this._area.item.width - this._area.width)) * SCRUNCH_FACTOR;
						this.x = this._init_x + this._area.width - MARGINS*2 - this.height;
					} else {
						this.height = this._init_height;
						this.x = this._init_x + (this._area.width - MARGINS*2) * val - this.height * val;
					}
					this.rotation = 270;
				break;
			}
		}
		public function show():void {
			clearInterval(this._alpha_id);
			this.alpha = ALPHA_1;
			
			this._alpha_id = setInterval(function() {
				alpha -= 0.04;
				if(alpha <= 0) clearInterval(_alpha_id);
			}, 4);
		}
	}
}