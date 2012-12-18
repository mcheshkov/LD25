/**
 * Created with IntelliJ IDEA.
 * User: cheshkov
 * Date: 16.12.12
 * Time: 17:37
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.media.Sound;
import flash.media.SoundChannel;

public class Man extends Sprite{

    [Embed(source="assets/fon_r.jpg")]
    var a:Class;
    var b:Bitmap = new  Bitmap(new a().bitmapData);
    [Embed(source="assets/mann.mp3")]
    var s:Class;
    private var sndChannel:SoundChannel = new SoundChannel();
    public function Man() {
        buttonMode = true;
        addChild(b);
        addEventListener(Event.ADDED_TO_STAGE,function(){
            var currentSound:Sound = new s() as Sound;
            sndChannel = currentSound.play();
        });
    }
}
}
