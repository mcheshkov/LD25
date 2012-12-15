package
{
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

import mx.utils.NameUtil;

/**
 * ...
 * @author
 */
public class Play extends Sprite
{

    static var c1 = 0x33000000;
    static var c2 = 0x00000000;
    static var m1 = [
        [c1,c1, c1,c1],
        [c1,c2, c2,c2],
        [c1,c2, c2,c2],
        [c1,c2, c2,c2]
    ];

    static var bd:BitmapData;

    var allCont:Sprite;

    var curF:Function;
    var curT:Number = 0;
    var curP:Point = new Point(-325,-225);

    var currentTime:int;
    var prevTime:int;
    var objCont:Sprite;
    var curvCont:Sprite;
    var oldCont:Sprite;
    var old = [];

    var koridor = [
        {from:new Point(-350,-250),to:new Point(-300,-250)},
        {from:new Point(-300,-250),to:new Point(-300, 200)},
        {from:new Point(-300, 200),to:new Point( 300, 200)},
        {from:new Point( 300, 200),to:new Point( 300,-250)},
        {from:new Point( 300,-250),to:new Point( 350,-250)},
        {from:new Point( 350,-250),to:new Point( 350, 250)},
        {from:new Point( 350, 250),to:new Point(-350, 250)},
        {from:new Point(-350, 250),to:new Point(-350,-250)}
    ];

    var korCont:Sprite;

    var pla:Player = new Player();

    public function Play():void
    {
        if (stage) init();
        else addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event = null):void
    {

        removeEventListener(Event.ADDED_TO_STAGE, init);



        bd = new BitmapData(4,4);
        for (var i=0;i<4;i++)
            for(var j=0;j<4;j++)
                bd.setPixel32(i, j, m1[i][j]);

        allCont = new Sprite();
        addChild(allCont);


        objCont = new Sprite();
        addChild(objCont);

        curvCont = new Sprite();
        addChild(curvCont);

        oldCont = new Sprite();
        addChild(oldCont);

        korCont = new Sprite();
        korCont.x = 400;
        korCont.y = 300;
        addChild(korCont);

        addEventListener(Event.ENTER_FRAME,onEnterFrame);
        stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);


        var tf:TextField = new TextField();
        var ttf:TextFormat = new TextFormat(null,48);
        tf.text = "Hi!";
        tf.setTextFormat(ttf);
        tf.x = 100;
        tf.y = 100;
        allCont.addChild(tf);

        curT = 0;
        curF = gen(liss,curT,curP);

        bg();
        tr();
        kor();
        char();

//            var s:Sprite = new Sprite();
//            s.graphics.beginFill(0x00cc0022);
//            s.graphics.drawCircle(300,300,50);
//            addChild(s);
//
//            var m1 = [
//                0,0,0,0,0,
//                0,0,0,0,0,
//                0.1,0.5,1,0.5,0.1,
//                0,0,0,0,0,
//                0,0,0,0,0
//            ];
//
//            var m2 = [
//                0,0,0.1,0,0,
//                0,0,0.5,0,0,
//                0,0,1,0,0,
//                0,0,0.5,0,0,
//                0,0,0.1,0,0
//            ];
//
//            var m3 = [
//                1,0,0,0,100,
//                0,1,0,0,100,
//                0,0,1,0,100,
//                0,0,0,1,0
//            ];
//
//            var b = new BitmapData(4,1);
//            b.setPixel(0,0,0xffffffff);
//            b.setPixel(1,0,0xffffffff);
//            b.setPixel(2,0,0x00000000);
//            b.setPixel(3,0,0x00000000);
//
//            root.filters = [new ColorMatrixFilter(m3), new DisplacementMapFilter(b,new Point(0,0),BitmapDataChannel.RED)];
        // entry point

        dScan();
    }

    public function char():void{
        objCont.graphics.beginFill(0xff00ff);
        objCont.graphics.drawRect(-5,-5,5,5);
    }

    public function dScan(){
        allCont.graphics.beginBitmapFill(bd);
        allCont.graphics.drawRect(0,0,800,600);
        allCont.graphics.endFill();
    }

    public function kor(){
        korCont.graphics.lineStyle(1,0x883e8f);

        for (var i in koridor){
            korCont.graphics.moveTo(koridor[i].from.x, koridor[i].from.y);
            korCont.graphics.lineTo(koridor[i].to.x, koridor[i].to.y);
        }
    }

    public function bg():void{
        var cont:Sprite = new Sprite();

        cont.graphics.beginFill(0x013662);
        cont.graphics.drawRect(0,0,800,600);



        allCont.addChild(cont);

//        cont.graphics.lineStyle(1,0x042546);
//
//        for (var i=0;i<10;i++){
//            cont.graphics.moveTo(0,i*60);
//            cont.graphics.lineTo(800,i*60);
//        }
//
//        for (var i=0;i<10;i++){
//            cont.graphics.moveTo(80*i,0);
//            cont.graphics.lineTo(80*i,600);
//        }
    }

    function xy1(t:Number):Point{
        return new Point(t,0.01*t*t);
    }

    function liss(t:Number){

        //trace()
        var _t = t/100000;
        return new Point(100*Math.sin(3*_t),100*Math.sin(4*_t));
    }

    function gen(xy:Function, tbase:Number, pbase:Point):Function{
        return function(t:Number){
            var _t = t - tbase;
            var res: Point = xy(_t);
            res.x += pbase.x;
            res.y += pbase.y;
            return res;
        }
    }
    function scaleT(f:Function,scaleX:Number,scaleY:Number){
        return function(t:Number){
            var r1 = f(scaleX*t);
            var r2 = f(scaleY*t);
            return new Point(r1.x,r2.y);
        }
    }
    function scaleXY(f:Function,scaleX:Number,scaleY:Number){
        return function(t:Number){
            var r1 = f(t);
            return new Point(scaleX * r1.x,scaleY * r1.y);
        }
    }

    function spir(t:Number){
        var _t = t/5000+15;
        var ee = Math.exp(0.2*_t);
        var ee0 = Math.exp(0.2*15);
        var c0 = Math.cos(15);
        var s0 = Math.sin(15);
        return new Point(ee*Math.cos(_t) - ee0*c0,ee*Math.sin(_t) - ee0*s0)
    }

    function xy2(t:Number):Point{
        return new Point(100*Math.sin(3*t),100*Math.sin(4*t));
    }


    public function tr():void{
        if (contains(curvCont))
            removeChild(curvCont);

        curvCont = new Sprite();

        curvCont.x = 400;
        curvCont.y = 300;

        curvCont.graphics.moveTo(curP.x, curP.y);
        curvCont.graphics.lineStyle(1,0x06aeaf);

        var tt = curT;
        for (var t=0;t<1000*10;t+=100){
            var p: Point = curF(curT + t);

            curvCont.graphics.curveTo(p.x,p.y,p.x,p.y);
        }

        //old.push({x:curF(curT).x,y:curF(curT).y});

        curvCont.filters = [new GlowFilter(0x0dfbeb,0.3,6,6,3)];

        addChild(curvCont);

        //oldTr();
    }

    function oldTr(){
        if (old.length < 2) return;

        oldCont.graphics.moveTo(old[0].x  +400,old[0].y +300);
        oldCont.graphics.lineStyle(1,0x06aeaf);
        for (var i=1;i<old.length;i++){
            oldCont.graphics.curveTo(old[i].x + 400,old[i].y+ 300,old[i].x+ 400,old[i].y+ 300);
        }
    }

    public function onEnterFrame(e:Event){
        currentTime = getTimer();
        var diff = currentTime - prevTime;

        prevTime = currentTime;//update for next go around

        curT += diff;

        var oldP:Point = curP;
        curP = curF(curT);
        tr();
        TweenLite.to(objCont,0.1,{x:400+curP.x, y:300+curP.y});

        for (var i in koridor){
            trace("INTER");
            trace(oldP);
            trace(curP);
            trace(koridor[i].from);
            trace(koridor[i].to);
            if (intersect(oldP, curP,koridor[i].from,koridor[i].to)){
                trace("ALERT");
            }
        }
    }

    function area(a:Point, b:Point, c:Point):Number {
        return (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x);
    }

    function intersect_1 (a:Number, b:Number, c:Number, d:Number):Boolean {
        var t:Number;
        if (a > b){
            t = a;
            a=b;
            b=t;
        }
        if (c > d){
            t = c;
            c=d;
            d=t;
        }
        return Math.max(a,c) <= Math.min(b,d);
    }

    function intersect (a:Point, b:Point, c:Point, d:Point):Boolean {
        return intersect_1 (a.x, b.x, c.x, d.x)
                && intersect_1 (a.y, b.y, c.y, d.y)
                && area(a,b,c) * area(a,b,d) <= 0
                && area(c,d,a) * area(c,d,b) <= 0;
    }

    public function onKeyDown(e:KeyboardEvent){
        trace(curP);

        pla.drug();
        var ff : Function;
        if (Math.random()<0.5){
            ff = liss;

        }
        else
            ff =  spir;

        var stx,sty,ssx,ssy;
        stx = 1 + Math.random() * 0.1;
        sty = 1 + Math.random() * 0.1;
        ssx = 0.5 + Math.random() * 1.5;
        ssy = 0.5 + Math.random() * 1.5;


        curF = gen(scaleXY(scaleT(ff,stx,sty),ssx, ssy),curT,curP);
        tr();
        trace(curP);
    }

}

}