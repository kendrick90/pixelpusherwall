import java.util.List;

void zigzagscrape(int zig) {
  // scrape for the strips
  loadPixels();
  if (testObserver.hasStrips) {
    registry.startPushing();
    List<Strip> strips = registry.getStrips();

    // yscale = how many pixels of y    one led strip == float(strips.size())
    // xscale = how many pixels of x    one led pixel == float(strips.get(0).getLength())

    float zigWidth = (float(strips.size())*zig); // 8*4=32
    float zigHeight = (float(strips.get(0).getLength())/zig); // 160/4=40

    float xscale = float(width) / zigWidth; //10
    float yscale = float(height) / zigHeight;  //10

    // for each strip 
    int stripNum = 0;
    for (Strip strip : strips) {
      for (int zag = 0; zag < zig; zag++) {
        for (int ledNumZag = 0; ledNumZag < zigHeight; ledNumZag++) {
          if (zag%2 == 0) {
            color c = get(int((float(stripNum)*zig+zag)*xscale), int((zigHeight-float(ledNumZag))*yscale)); //vertical orientation
            strip.setPixel(c, int(ledNumZag+(zag*zigHeight)));
          }
          if (zag%2 == 1) {
            color c2 = get(int((float(stripNum)*zig+zag)*xscale), int((float(ledNumZag))*yscale)); //vertical orientation
            strip.setPixel(c2, int(ledNumZag+(zag*zigHeight)));
          }
          // strip.setPixel(c, int(ledNumZag+(zag*zigHeight)));
        }
      }
      stripNum++;
    }
  }
}
