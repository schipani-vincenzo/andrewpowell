package net.infoaccelerator.controls
{
	  import flash.display.Sprite;
	  import flash.display.StageScaleMode;
	  import flash.display.StageAlign;
	  import flash.filters.DropShadowFilter;
	  import flash.events.Event;
	
	  import com.mapquest.tilemap.TileMap;
	  import com.mapquest.tilemap.Size;
	  import com.mapquest.tilemap.controls.LargeZoomControl;
	  import com.mapquest.tilemap.controls.ViewControl;
	  import com.mapquest.PointLL;
	  import com.mapquest.tilemap.RectLL;
	  import com.mapquest.tilemap.overlays.EllipseOverlay;
	  import flash.geom.Rectangle;
	  import com.mapquest.tilemap.overlays.LineOverlay;
	  import com.mapquest.tilemap.overlays.PolygonOverlay;
	  import com.adobe.viewsource.ViewSource;
	
	  [SWF(backgroundColor="#ffffff")]
	  public class SimpleOverlay extends Sprite
	  {
	    private var map:TileMap;
	    
	    public function SimpleOverlay()
	    {
		  //com.adobe.viewsource.ViewSource.addMenuItem(this,"../srcview/source/SimpleOverlay.as.html");			
	    	
	      this.stage.align = StageAlign.TOP_LEFT;
	      this.stage.scaleMode = StageScaleMode.NO_SCALE;
	      this.stage.addEventListener(Event.RESIZE, this.onStageResize);
	      
	      this.map = new TileMap("mjtd%7Clu6t2h072h%2C20%3Do5-gfy25", 4);
	      this.map.setSize(new Size(600, 450));
	      this.map.addControl(new LargeZoomControl());
	      this.map.addControl(new ViewControl());
	      this.addChild(this.map);
	      
	      this.map.filters = [new DropShadowFilter(4, 45, 0, 0.8, 10, 10)];
	
	      var dc:PointLL = new PointLL(38.895, -77.036697);
	      this.map.setCenter(dc);
	      
	      //death within 14 days
	      var rLat:Number = 90 / 69;
	      var rLng:Number = 90 / 53;
	      var rect:RectLL = new RectLL(new PointLL(dc.lat-rLat, dc.lng-rLng), new PointLL(dc.lat+rLat, dc.lng+rLng));
	      var circle:EllipseOverlay = new EllipseOverlay();
	      circle.setFillColor(0xffff00);
	      circle.setFillColorAlpha(.25);
	      circle.setBorderWidth(-1);
	      circle.setShapePoints(rect);
	      this.map.addOverlay(circle);
	
	      //death within 1 days
	      rLat = 30 / 69;
	      rLng = 30 / 53;
	      rect = new RectLL(new PointLL(dc.lat-rLat, dc.lng-rLng), new PointLL(dc.lat+rLat, dc.lng+rLng));
	      circle = new EllipseOverlay();
	      circle.setFillColor(0xff0000);
	      circle.setFillColorAlpha(.25);
	      circle.setBorderWidth(-1);
	      circle.setShapePoints(rect);
	      this.map.addOverlay(circle);
	
	      //imediate death radius 7.4 miles
	      rLat = 7.4 / 69;
	      rLng = 7.4 / 53;
	      rect = new RectLL(new PointLL(dc.lat-rLat, dc.lng-rLng), new PointLL(dc.lat+rLat, dc.lng+rLng));
	      circle = new EllipseOverlay();
	      circle.setFillColor(0xff0000);
	      circle.setFillColorAlpha(.50);
	      circle.setBorderWidth(-1);
	      circle.setShapePoints(rect);
	      this.map.addOverlay(circle);
	
	      this.onStageResize(null); 
	    }
	    
	    private function onStageResize(evt:Event):void {
	      this.map.x = Math.floor(this.stage.stageWidth/2 - this.map.width/2);
	      this.map.y = Math.floor(this.stage.stageHeight/2 - this.map.height/2);
	    }
	  }
}