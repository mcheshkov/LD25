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

public class ClickMe extends Sprite{

    [Embed(source="assets/click.png")]
    var a:Class;
    var b:Bitmap = new  Bitmap(new a().bitmapData);
    public function ClickMe() {
        buttonMode = true;
        addChild(b);
    }
}
}
