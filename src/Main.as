package {
import adobe.utils.XMLUI;

import avmplus.typeXml;

import com.greensock.TweenLite;

import flash.display.Bitmap;

import flash.display.BitmapData;
import flash.display.BitmapDataChannel;
import flash.display.Shader;

import flash.display.Sprite;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.filters.BlurFilter;
import flash.filters.ColorMatrixFilter;
import flash.filters.ConvolutionFilter;
import flash.filters.DisplacementMapFilter;
import flash.filters.GlowFilter;
import flash.filters.ShaderFilter;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.utils.getTimer;
import flash.utils.setTimeout;



import mx.utils.NameUtil;

/**
 * ...
 * @author
 */
[Frame(factoryClass="Preloader")]
[SWF(width=800, height=600, backgroundColor=0x000000)]
public class Main extends Sprite {


    [Embed(source="scan.pbj", mimeType="application/octet-stream")]
    var shad:Class;
    var sss:Shader;
    var sssF:ShaderFilter;

    [Embed(source="col.pbj", mimeType="application/octet-stream")]
    var co_shad:Class;
    var co_sss:Shader;
    var co_sssF:ShaderFilter;

    [Embed(source="vin.pbj", mimeType="application/octet-stream")]
    var vin_shad:Class;
    var vin_sss:Shader;
    var vin_sssF:ShaderFilter;



    public var pl:Play;

    public function Main():void {
        if (stage) init();
        else addEventListener(Event.ADDED_TO_STAGE, init);
    }

    var cc:ClickMe = new ClickMe();
    var mm:Man = new Man();
    private function init(e:Event = null):void {
        sss = new Shader(new shad());
        sss.data.alpha.value = [0.5];
        sss.data.offset.value = [0.1];
        sssF = new ShaderFilter(sss);

        co_sss = new Shader(new co_shad());
        co_sssF = new ShaderFilter(co_sss);

        vin_sss = new Shader(new vin_shad());
        vin_sssF = new ShaderFilter(vin_sss);

        vin_sss.data.w.value = [800.0];
        vin_sss.data.h.value = [600.0];

        root.filters = [co_sssF,sssF,vin_sssF];




        addEventListener(Event.ENTER_FRAME,enter);
        removeEventListener(Event.ADDED_TO_STAGE, init);

        stage.scaleMode = StageScaleMode.SHOW_ALL;

       pl = new Play();
       stage.addEventListener(MouseEvent.MOUSE_DOWN, function(e:Event):void{x
           trace("click");
           if (contains(cc))
               removeChild(cc);
           addChild(mm);
           flash.utils.setTimeout(function(){
               if (contains(mm))
                   removeChild(mm);
               addChild(pl);
           },15000);
           flash.utils.setTimeout(function(){
               TweenLite.to(this,1,{c:1});
           },4000);
       });
        addChild(new ClickMe());
//        a();
//        o();
        r();
        g();
        b();
    }

    function a(){
        TweenLite.to(this, 0.1,{aa:Math.random()*0.5 });
        setTimeout(a, 100);
    }

    function o(){
        TweenLite.to(this, 0.5,{oo:Math.random()*0.1});
        setTimeout(o, 500);
    }


    function r(){
        TweenLite.to(this, 4,{rr:Math.random()*1 - 0.5});
        setTimeout(r, 4000);
    }


    function g(){
        TweenLite.to(this, 8,{gg:Math.random()*1 - 0.5});
        setTimeout(g, 8000);
    }


    function b(){
        TweenLite.to(this, 6,{bb:Math.random()*1 - 0.5});
        setTimeout(b, 6000);
    }


    var fn:uint = 0;

    public var aa:Number = 0;
    public var oo:Number =0;
    public var rr:Number =0;
    public var gg:Number =0;
    public var bb:Number =0;
    public function enter(e:Event){
        fn++;

        if (fn%1 == 0){
            var to_a = Math.random()* 0.6 - 0.3;
            to_a /=10;
            var to_o = Math.random()* 0.6 - 0.3;
            to_o /=10;

            if (sss.data.alpha.value[0] > 1) to_a = -0.2;
            if (sss.data.offset.value[0] > 1) to_o = -0.2;

            fn = 0;
            var to_r = Math.random() * 0.2 - 0.1;
            var to_g = Math.random() * 0.2 - 0.1;
            var to_b = Math.random() * 0.2 - 0.1;

//            TweenLite.to(co_sss.data.or.value,1,{0:to_r});
//            TweenLite.to(co_sss.data.og.value,1,{0:to_g});
//            TweenLite.to(co_sss.data.ob.value,1,{0:to_b});

            //}

//            sss.data.alpha.value = [sss.data.alpha.value[0] + to_a];
//            sss.data.offset.value = [sss.data.offset.value[0] + to_o];

            sss.data.alpha.value = [Math.random() * 0.2 + 0.3];
            sss.data.offset.value = [Math.random() * 0.2 + 0.1];

            if(Math.random() < 0.01){


                sss.data.alpha.value = [0.5];
                sss.data.offset.value = [0.1];
            }


        }

//        sss.data.alpha.value = [aa];
//        sss.data.offset.value = [oo];
        co_sss.data.or.value=[rr];
        co_sss.data.og.value=[gg];
        co_sss.data.ob.value=[bb];

        root.filters = [co_sssF,sssF,vin_sssF];
        //root.filters = [];

        graphics.beginFill(0xffffffff,c);
        graphics.drawRect(0,0,800,600);

    }

    var c:Number = 1;
}
}