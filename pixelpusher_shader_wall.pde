import com.heroicrobot.dropbit.registry.*;
import com.heroicrobot.dropbit.devices.pixelpusher.Pixel;
import com.heroicrobot.dropbit.devices.pixelpusher.Strip;

import processing.core.*;
import java.util.*;

DeviceRegistry registry;

PImage img;
// PGraphics pgr; // Canvas to receive a texture
PShader noise;


boolean ready_to_go = true;
int lastPosition;
TestObserver testObserver;

void setup() {
    frameRate(120);
  ((PGraphicsOpenGL)g).textureSampling(3);
  size(160, 320, P2D);
  surface.setResizable(true);
  // pgr = createGraphics(width, height, PConstants.P2D);
  // img = createImage(width, height, ARGB);
  registry = new DeviceRegistry();
  testObserver = new TestObserver();
  registry.addObserver(testObserver);
  background(0);
  noise = loadShader("wombatSN3D.glsl");
  // noise = loadShader("rainbowHueHSB.glsl");
  // noise.set("u_resolution", 200.0, 200.0);
  noise.set("u_resolution", float(width), float(height));
}

void draw() {
  noise.set("u_time", millis() / 1000.0);
  shader(noise);
  rect(0, 0, width, height);
  if (frameCount % 10 == 0) {  // every 10th frame
    println("frame: " + frameCount + " - fps: " + frameRate);
  }
  // image(img, 0, 0, width, height);
  zigzagscrape(4);
  // scrape();
}

void stop()
{
  super.stop();
}
