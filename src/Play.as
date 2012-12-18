package
{
import com.greensock.TweenLite;

import flash.display.Bitmap;
import flash.display.BitmapData;

import flash.display.Shader;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.filters.GlowFilter;
import flash.filters.ShaderFilter;
import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.utils.getTimer;

/**
 * ...
 * @author
 */
public class Play extends Sprite
{
    var allCont2:Sprite;
    var allCont:Sprite;


    var currentTime:int;
    var prevTime:int;

    var objCont:Sprite;
    var curvCont:Sprite;
    var oldCont:Sprite;
    var old = [];

    var pla:Player = new Player();

    public function Play():void
    {
        if (stage) init();
        else addEventListener(Event.ADDED_TO_STAGE, init);
    }


    public var oldBMP:Bitmap;

    var mapW = 4000;
    var mapH = 6000;

    var curF:Function;
    var drawF:Function;
    var curT:Number = 0;

    var target:Bitmap;
    var target_data:BitmapData;

    //var curAngle:Number = Math.PI/2;
    var curAngle:Number = 0;
    var curDir:Point = new Point(Math.cos(curAngle),Math.sin(curAngle));


    private function init(e:Event = null):void
    {

        target_data = new BitmapData(800,600);
        target = new Bitmap(target_data);
        addChild(target);

        removeEventListener(Event.ADDED_TO_STAGE, init);

        allCont = new Sprite();
        allCont2 = new Sprite();
        allCont2.addChild(allCont);
        //addChild(allCont);
        bg();

        trace("curF in init");
        //curF = gen(down, curT, new Point(xx.x, xx.y));
        curF = gen(psin(curDir,0.3), curT, new Point(xx.x, xx.y));
        drawF = gen(psin(curDir,5), curT, new Point(xx.x, xx.y));
        a();


        objCont = new Sprite();
        allCont.addChild(objCont);

        tr_data = new BitmapData(mapW, mapH,true,0x00000000);
        tr_bmp = new Bitmap(tr_data);

        curvCont = new Sprite();
        allCont.addChild(curvCont);
        curvCont.filters = [new GlowFilter(0x0dfbeb,0.3,3,3,4)];
        curvCont.graphics.lineStyle(1,0x06aeaf);
        //curvCont.addChild(tr_bmp);

        oldCont = new Sprite();
        allCont.addChild(oldCont);

        addEventListener(Event.ENTER_FRAME,onEnterFrame);
        stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);


        var tf:TextField = new TextField();
        var ttf:TextFormat = new TextFormat(null,48);
        tf.text = "Hi!";
        tf.setTextFormat(ttf);
        tf.x = 100;
        tf.y = 100;
        allCont.addChild(tf);




        var tox = xx.x - 400 + Math.random()*50;
        var toy = xx.y - 300 + Math.random()*50;
            tox = Math.max(0,tox);
            tox = Math.min(mapW - 800,tox);
            toy = Math.max(0,toy);
            toy = Math.min(mapH - 600,toy);

        allCont.x = -tox;
        allCont.y = -toy;

//        curT = 0;
//        curF = gen(evo_w,curT,curP);

        tr();
        chara();

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



        //addChild(moveCont);
    }

    public function chara():void{
        objCont.graphics.beginFill(0xff00ff);
        objCont.graphics.drawRect(-5,-5,5,5);
    }

//    [Embed(source="assets/fon_r.jpg")]
    //[Embed(source="assets/mapt.jpg")]
    [Embed(source="assets/text_4k.jpg")]
    //[Embed(source="assets/text.jpg")]
    //[Embed(source="assets/text_6k.jpg")]
    public var fon:Class;
//    [Embed(source="assets/mapr.png")]
//    public var fon:Class;
    var fon_map:Bitmap = new Bitmap((new fon()).bitmapData);

    [Embed(source="assets/gray_biger_4k.png")]
    //[Embed(source="assets/gray_biger.png")]
    //[Embed(source="assets/gray_biger_6k.png")]
    public var lev:Class;
    var lev_map:Bitmap = new Bitmap((new lev()).bitmapData);

    public function bg():void{
        var cont:Sprite = new Sprite();

        cont.addChild(fon_map);

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

    function ssin(amp:Number):Function{
        var a = [];
        var w = [];
        var p = [];
        var count = 7;
        for (var i=0;i<count;i++){
            a.push(Math.random()*amp);
            w.push(Math.random()*Math.PI);
            p.push(Math.random() * Math.PI);
            //p.push(0);
        }

        return function (t:Number):Number{
            var res:Number = 0;
            for (var i = 0;i<count;i++){
                res += a[i] * Math.sin(w[i]*t + p[i]);
            }
            return res;
        }
    }

    function psin(dir:Point,amp:Number):Function{
        var ss:Function = ssin(amp);
        return function(t:Number):Point{
            t/=50;

            var res:Point = new Point(0,0);
            res.x += dir.x * t;
            res.y += dir.y * t;

            res.x += dir.y * ss(t);
            res.y -= dir.x * ss(t);
            return res;
        }
    }

    function left(t:Number):Point{
        return new Point(-t/100, 0);
    }

    function right(t:Number):Point{
        return new Point(t/100, 0);
    }

    function up(t:Number):Point{
        return new Point(0, -t/100);
    }

    function down(t:Number):Point{
        trace("down got " + t);
        return new Point(0, t/100);
    }

    var dir:Point;
    var ph:Number;

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
//        if (contains(curvCont))
//            removeChild(curvCont);
//
//        curvCont = new Sprite();
//
//        curvCont.x = 400;
//        curvCont.y = 300;
//
//        curvCont.graphics.moveTo(curP.x, curP.y);
//        curvCont.graphics.lineStyle(1,0x06aeaf);
//
//        var tt = curT;
//        for (var t=0;t<1000*10;t+=100){
//            var p: Point = curF(curT + t);
//
//            curvCont.graphics.curveTo(p.x,p.y,p.x,p.y);
//        }
//
//        //old.push({x:curF(curT).x,y:curF(curT).y});
//
//        curvCont.filters = [new GlowFilter(0x0dfbeb,0.3,6,6,3)];
//
//        addChild(curvCont);
//
//        //oldTr();
    }

    function oldTr(){
        if (old.length < 2) return;

        oldCont.graphics.moveTo(old[0].x  +400,old[0].y +300);
        oldCont.graphics.lineStyle(1,0x06aeaf);
        for (var i=1;i<old.length;i++){
            oldCont.graphics.curveTo(old[i].x + 400,old[i].y+ 300,old[i].x+ 400,old[i].y+ 300);
        }
    }

    function getSpd(x:Point):Point{
        var res:Point = new Point;

        var fl_x:Number = Math.floor(x.x);
        var fl_y:Number = Math.floor(x.y);

        var up_x:Number = fl_x + 1;
        var up_y:Number = fl_y + 1;

        var w_x:Number = x.x - fl_x;
        var w_y:Number = x.y - fl_y;

        res.x = w_x * (w_y * (bmp_x.bitmapData.getPixel(fl_x,fl_y) % 256 - 128) +
                (1.0 - w_y) * (bmp_x.bitmapData.getPixel(fl_x,up_y) % 256 - 128)) +
                (1.0 - w_x) * (w_y * (bmp_x.bitmapData.getPixel(up_x,fl_y) % 256 - 128) +
                        (1.0 - w_y) * (bmp_x.bitmapData.getPixel(up_x,up_y) % 256 - 128));

        res.y = w_x * (w_y * (bmp_y.bitmapData.getPixel(fl_x,fl_y) % 256 - 128) +
                (1.0 - w_y) * (bmp_y.bitmapData.getPixel(fl_x,up_y) % 256 - 128)) +
                (1.0 - w_x) * (w_y * (bmp_y.bitmapData.getPixel(up_x,fl_y) % 256 - 128) +
                        (1.0 - w_y) * (bmp_y.bitmapData.getPixel(up_x,up_y) % 256 - 128));


        var norm:Number = Math.sqrt(res.x * res.x + res.y * res.y);

        res.x /= norm;
        res.y /= norm;


        return res;
    }

    function getCoords(x:Point):Array{
        var res = [];
        var c:Point = new Point;
        c.x = x.x;
        c.y = x.y;
        trace("co" + c);
        for (var i=0;i<1000;i++){
            res.push({x:c.x,y:c.y});
            c.x += getSpd(c).x ;
            c.y += getSpd(c).y;
            trace("ct" + c);
        }
        return res;
    }

    var tr_data:BitmapData;
    var tr_bmp:Bitmap;

    var fn =0;
    public function onEnterFrame(e:Event){

        currentTime = getTimer();
        var diff = currentTime - prevTime;

        prevTime = currentTime;//update for next go around

        curT += diff;

        //var sd:Array = getCoords(xx);

        var next = curF(curT);

//        var ttr:Sprite = new Sprite();
//        ttr.graphics.moveTo(xx.x, xx.y);
//        ttr.graphics.lineStyle(1,0x06aeaf);
//        ttr.graphics.lineTo(next.x,next.y);
//        tr_data.draw(ttr);
        //tr_bmp.bitmapData = tr_data;


        var to:Point;
        to = new Point(next.x, next.y);
        curvCont.graphics.clear();
        curvCont.graphics.lineStyle(1,0x86aeaf);
        curvCont.graphics.moveTo(xx.x, xx.y);
        for (var i=0;i<5000;i+=100){
            curvCont.graphics.lineTo(to.x,to.y);
            to = drawF(curT+i);
        }


        for (var i =0;i<30;i++){
            var xr = Math.random() * 30 - 15 + xx.x;
            var yr = Math.random() * 30 - 15 + xx.y;
            var xm1 = xx.x * 1/3 + xr * 2/3;
            var ym1 = xx.y * 1/3 + yr * 2/3;
            var xm2 = xx.x * 2/3 + xr * 1/3;
            var ym2 = xx.y * 2/3 + yr * 1/3;

            curvCont.graphics.moveTo(xx.x, xx.y);
            curvCont.graphics.lineStyle(1,0xcc0000,0.3);
            curvCont.graphics.curveTo(xm2 +Math.random() * 60 - 30, ym2+Math.random() * 60 - 30, xm2 +Math.random() * 30 - 15,ym2 +Math.random() * 30 - 15);
            curvCont.graphics.curveTo(xm1 +Math.random() * 60 - 30, ym1+Math.random() * 60 - 30, xm1 +Math.random() * 30 - 15,ym1 +Math.random() * 30 - 15);
            curvCont.graphics.curveTo(xr, yr,xr+Math.random() * 30 - 15, yr+Math.random() * 30 - 15);
            curvCont.graphics.curveTo(xx.x, xx.y,xx.x+Math.random() * 30 - 15, xx.y+Math.random() * 30 - 15);

        }

        //TweenLite.to(xx,0.1,{x:sd[1].x, y:sd[1].y});

        //TweenLite.to(objCont,0.1,{x:sd[1].x, y:sd[1].y});

        //TweenLite.to(xx,0.1,{x:next.x, y:next.y});

        xx.x = next.x;
        xx.y = next.y;
        objCont.x = next.x;
        objCont.y = next.y;

        //TweenLite.to(objCont,0.1,{x:next.x, y:next.y});


        if (xx.x - (-allCont.x) < 100 ||
                (-allCont.x) + 800 - xx.x  < 100 ||
                xx.y - (-allCont.y) < 100 ||
                (-allCont.y) + 600 - xx.y < 100){
            var tox:Number;
            var toy:Number;
            tox = xx.x - 400 + Math.random()*50;
            toy = xx.y - 300 + Math.random()*50;
            tox = Math.max(0,tox);
            tox = Math.min(mapW - 800,tox);
            toy = Math.max(0,toy);
            toy = Math.min(mapH - 600,toy);

            TweenLite.to(allCont,3,{x:-tox, y:-toy});
        }

        if (lev_map.bitmapData.getPixel(xx.x, xx.y) % 256 < 8 ||
            xx.x < 0||
            xx.y < 0 ||
            xx.y> mapH ||
            xx.x > mapW){

                xx = new Point(xx_start.x, xx_start.y);
                trace("curF in bounds");

            //curAngle = Math.PI/2;
            curAngle = 0;
            curDir = new Point(Math.cos(curAngle),Math.sin(curAngle));
            curF = gen(psin(curDir,0.3),curT, new Point(xx.x, xx.y));
            drawF = gen(psin(curDir,5),curT, new Point(xx.x, xx.y));
                //curF = gen(down, curT, new Point(xx.x, xx.y));
            var tox = xx.x - 400 + Math.random()*50;
            var toy = xx.y - 300 + Math.random()*50;
                TweenLite.to(allCont,1,{x:-tox, y:-toy});
                TweenLite.to(objCont,1,{x:xx.x, y:xx.y});
        }

        //curvCont.graphics.lineStyle(2,0x06aeaf);
        //curvCont.graphics.moveTo(sd[0].x,  sd[0].y);

//        for (var i in sd) {
//            if (i == 0) continue;
//            if ((sd[0].x - sd[i].x) * (sd[0].x - sd[i].x) +
//                    (sd[0].y - sd[i].y) * (sd[0].y - sd[i].y) > 100) break;
//            curvCont.graphics.lineTo(sd[i].x,  sd[i].y);
//
//        }


//        curT += diff;
//
//        var oldP:Point = curP;
//        curP = curF(curT);
//        tr();
//        TweenLite.to(objCont,0.1,{x:curP.x +400, y:curP.y+300});
//
//        for (var i in koridor){
//            if (intersect(oldP, curP,koridor[i].from,koridor[i].to)){
//                trace("ALERT");
//            }
//        }

        target_data.draw(allCont2);
        target.bitmapData = target_data;
    }

    function a(){
        drawF = gen(psin(curDir,15),curT, new Point(xx.x, xx.y));
//        rev.randomize();
        flash.utils.setTimeout(a, Math.random()*15000+3000);
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

    var move = [];
    var moveCont:Sprite;

    [Embed(source="assets/map_x.png")]
    var map_x:Class;
    var bmp_x:Bitmap = new map_x();

    [Embed(source="assets/map_y.png")]
    var map_y:Class;
    var bmp_y:Bitmap = new map_y();

    public function integ(){
//        var a = [];
//        var v = [];
//        var x = [];
//
//        for (var i=0;i<0.5;i+=0.001){
//            x.push(i);
//            a.push(Math.random());
//        }
//
//        var mu = 1;
//        for (var i in x){
//            v.push((a[i] + x[i])/(mu*(1-x[i]*x[i])));
//        }
//
//
//        var cx = Math.random() * 0.3;
//
//
//        var move = []
//        for (var i=0;i<100;i++){
//            move.push(cx);
//            cx += v[Math.floor(cx/0.001)];
//        }

        var x = 440;
        var y = 180;
        var vx = -2;
        var vy = 1;

        var ax;
        var ay;

        var mux = 0.2;
        var muy = 0.1;

        var bmp_x:Bitmap = new map_x();


        for (var i=0;i<600;i++){
            move.push({x:x, y:y});
            x += vx;
            y += vy;

            //v += mu*(1-x*x)*v - x;
            //vx += 0.1*mux*(1-x*x)*vx - x;
            vx += (bmp_x.bitmapData.getPixel(x, y) % 256 - 128) * 0.1;
            vy += (bmp_x.bitmapData.getPixel(y, x) % 256 - 128) * 0.1 ;
            //vy += Math.random() * 10 - 5;
        }
    }

    var dist = [];

    function distClean(){
        dist = [];
        for (var i = 0;i<400;i++){
            dist[i] = [];
            for (var j = 0;j<400;j++){
                dist[i][j] = 99999;
            }
        }
    }

    function bfs(start: Point){
        var q = [];
        q.unshift(start);
        dist[200][200] = 0;
        while (q.length > 0){
            var c = q.pop();

            if (Math.random() > 1/(q.length+1)) continue;

            if(dist[c.x - start.x + 200][c.y - start.y + 200] > 200) continue;

            function xm(){
                if ( c.x-1 > 0 && dist[c.x - start.x - 1 + 200][c.y - start.y + 200] > dist[c.x - start.x + 200][c.y - start.y + 200] +1 && lev_map.bitmapData.getPixel(c.x -1,c.y) % 256 > 8){
                    dist[c.x - start.x - 1 + 200][c.y - start.y + 200] = dist[c.x - start.x + 200][c.y - start.y + 200] +1;
                    q.push(new Point(c.x-1,c.y))
                }
            }
            function xp(){

                if ( c.x+1 < mapW && dist[c.x - start.x + 1 + 200][c.y - start.y + 200] > dist[c.x - start.x + 200][c.y - start.y + 200] +1 && lev_map.bitmapData.getPixel(c.x +1,c.y) % 256 > 8){
                dist[c.x - start.x + 1 + 200][c.y - start.y + 200] = dist[c.x - start.x + 200][c.y - start.y + 200] +1;
                q.push(new Point(c.x+1,c.y))
            }
            }
            function ym(){

                if ( c.y-1 > 0 && dist[c.x - start.x + 200][c.y - start.y - 1 + 200] > dist[c.x - start.x + 200][c.y - start.y + 200] +1 && lev_map.bitmapData.getPixel(c.x,c.y - 1) % 256 > 8){
                dist[c.x - start.x + 200][c.y - start.y - 1 + 200] = dist[c.x - start.x + 200][c.y - start.y + 200] +1;
                q.push(new Point(c.x,c.y-1))
            }
            }
            function yp(){

                if ( c.y +1 < mapH && dist[c.x - start.x + 200][c.y - start.y + 1 + 200] > dist[c.x - start.x + 200][c.y - start.y + 200] +1 && lev_map.bitmapData.getPixel(c.x,c.y +1) % 256 > 8){
                dist[c.x - start.x + 200][c.y - start.y +1 + 200] = dist[c.x - start.x + 200][c.y - start.y + 200] +1;
                q.push(new Point(c.x,c.y+1))
            }
            }

            var fs = [xm,xp,ym,yp];
            for (var i=0;i<3;i++){
                if (Math.random() < 0.5){
                    fs[i] = fs[i+1];
                    var t = fs[i]
                    fs[i+1] = t;
                }
            }
            for (var i =0;i<4;i++){
                fs[i]();
            }
        }
    }

    function farAway(){
        var a = [];
        for (var i = 0;i<400;i++){
            for (var j = 0;j<400;j++){
                if (dist[i][j] < 99999)
                    a.push({x:i, y:j, d:dist[i][j]});
            }
        }
        a.sort(function(a,b):Number{return b.d - a.d});

        var count = 2;
        var res = [];
        for(var i =0; i<count;i++){
            var path = [];
            var cd = dist[a[i].x][a[i].y];
            var cx = a[i].x;
            var cy = a[i].y;

            path.unshift({x:cx, y:cy});

            while (cd != 0){
                if (cx >0 && dist[cx-1][cy] <= (cd -1)){
                    cx = cx-1;
                    cy = cy;
                    cd = cd-1;
                    path.unshift({x:cx, y:cy});
                    continue;
                }
                if (cx <399 && dist[cx+1][cy] <= (cd -1)){
                    cx = cx+1;
                    cy = cy;
                    cd = cd-1;
                    path.unshift({x:cx, y:cy});
                    continue;
                }
                if (cy >0 && dist[cx][cy-1] <= (cd -1)){
                    cx = cx;
                    cy = cy-1;
                    cd = cd-1;
                    path.unshift({x:cx, y:cy});
                    continue;
                }if (cy <399 && dist[cx][cy+1] <= (cd -1)){
                    cx = cx;
                    cy = cy+1;
                    cd = cd-1;
                    path.unshift({x:cx, y:cy});
                    continue;
                }
                break;
            }
            res.push(path);
        }

        return res;
    }

    var xx_start:Point = new Point(3240,5680);
    var xx:Point = new Point(xx_start.x, xx_start.y);
    var v:Point = new Point(0,0);

    function integ_evo():void{
        xx.x += v.x;
        xx.y += v.y;

        v.x += (bmp_x.bitmapData.getPixel(xx.x, xx.y) % 256 - 128) * 0.01;
        v.y += (bmp_y.bitmapData.getPixel(xx.x, xx.y) % 256 - 128) * 0.01;

        if (Math.abs(v.x) > 1 || Math.abs(v.y) > 1){
            var n:Number = v.x* v.x + v.y* v.y;
            v.x /= Math.sqrt(n);
            v.y /= Math.sqrt(n);
        }

        if (xx.x < 0 || xx.x > 800 || xx.y < 0 || xx.y > 600){
            v.x = 0;
            v.y = 0;
        }
    }

    function evo_w(t:Number):Point{
        trace("XX "  + xx);
        integ_evo();
        trace(new Point(xx.x, xx.y ));
        return new Point(xx.x, xx.y);
    }

    public function onKeyDown(e:KeyboardEvent){
//        trace(curP);

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

        //distClean();
        //bfs(new Point(xx.x, xx.y));
//        var rr = farAway();
//        curvCont.graphics.lineStyle(1,0xff0000);
//        curvCont.graphics.moveTo(rr[0][0].x+ xx.x - 200,rr[0][0].y+ xx.y - 200);
//        for (var i in rr[0]){
//            curvCont.graphics.lineTo(rr[0][i].x + xx.x - 200, rr[0][i].y + xx.y -200);
//        }


//        curF = gen(scaleXY(scaleT(ff,stx,sty),ssx, ssy),curT,curP);
        tr();

        trace("kc " + e.keyCode);

        //bmp_x.bitmapData.draw()

        //bmp_x.bitmapData.perlinNoise(2,2,2,Math.random(),true,true);
        //bmp_y.bitmapData.perlinNoise(2,2,2,Math.random(),true,true);
        var maxA = Math.PI / 4;

        if (e.keyCode == 37){ // left
            //v.x --;
            trace("curF in key");
            //curF = gen(left, curT, new Point(xx.x, xx.y));

            curAngle -= maxA / 8;
            curDir = new Point(Math.cos(curAngle),Math.sin(curAngle));

            curF = gen(psin(curDir,0.3),curT, new Point(xx.x, xx.y));
            drawF = gen(psin(curDir,5),curT, new Point(xx.x, xx.y));
        }
        if (e.keyCode == 39){ // right
            //v.x ++;
            trace("curF in key");
            //curF = gen(right, curT, new Point(xx.x, xx.y));

            curAngle += maxA / 8;
            curDir = new Point(Math.cos(curAngle),Math.sin(curAngle));

            curF = gen(psin(curDir,0.3),curT, new Point(xx.x, xx.y));
            drawF = gen(psin(curDir,5),curT, new Point(xx.x, xx.y));
        }
//        if (e.keyCode == 32){
//            var fs = [left, right, up,down];
//            var d = Math.floor(Math.random() * 4);
//            trace("curF in key");
//            curF = gen(fs[d],curT, new Point(xx.x, xx.y));
//        }
        if (e.keyCode == 32){
            var a: Number = Math.random() * maxA;
            if (a < Math.PI /4) a -= maxA / 2;
            curAngle += a;
            curDir = new Point(Math.cos(curAngle),Math.sin(curAngle));

            curF = gen(psin(curDir,0.3),curT, new Point(xx.x, xx.y));
            drawF = gen(psin(curDir,5),curT, new Point(xx.x, xx.y));
        }
    }

}

}


