package {
import adobe.utils.XMLUI;

import avmplus.typeXml;

import com.greensock.TweenLite;

import flash.display.Bitmap;

import flash.display.BitmapData;
import flash.display.BitmapDataChannel;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.filters.BlurFilter;
import flash.filters.ColorMatrixFilter;
import flash.filters.ConvolutionFilter;
import flash.filters.DisplacementMapFilter;
import flash.filters.GlowFilter;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.utils.getTimer;
import flash.events.MouseEvent;

import mx.utils.NameUtil;

/**
 * ...
 * @author
 */
[Frame(factoryClass="Preloader")]
[SWF(width=800, height=600, backgroundColor=0x888888)]
public class Main extends Sprite {

    public var pl:Play;
	public var pla:Player = new Player;

    public function Main():void {
        if (stage) init();
        else addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event = null):void {
        removeEventListener(Event.ADDED_TO_STAGE, init);
		stage.addEventListener(MouseEvent.MOUSE_DOWN, drug);
        pl = new Play();
		
		
		
        addChild(pl);
		
    }
	private function drug(e:MouseEvent):void {
		
		pla.drug();
		
		
	}
}
}