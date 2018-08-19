

// Levels refer to partial sums of a given function
// The goal level refers to the goal partial sum 
int goal_level = 3;
int scale = 100;

float angle = 0;

// List of values for the wave visualization
float[] wave = new float[100];

void setup() {
  size(500, 500);
  background(255);
  noFill();
  frameRate(60);
  
}


void draw() {
  background(255);
  angle = angle - .25;
  posUpdate(250, 250, (amplitude_Max(0) * scale) / 2, 0, angle);
  waveDraw();
  // delay(100);
  
}

// Draws new position based on new angle input
public void posUpdate(float center_x, float center_y, float radius, float curr_level, float theta) {
  float newpos = funcEval(radians(theta), curr_level);
  
  // Calculate new period and translate current angle
  float new_theta = (((2 * PI) / period_Max(curr_level))) * radians(theta);
  
  ellipse(center_x, center_y, radius * 2, radius * 2);
  line(center_x, center_y, center_x + radius * cos(new_theta), center_y + radius * sin(new_theta));
  
  // Get radius of new circle
  float new_radius = (amplitude_Max(curr_level + 1) * scale) / 2;
  
  
  // Adds new point to wave function visualizer
  wave[0] = center_y + radius * sin(new_theta);
  
  // Will continue evaluating sum until goal partial sum has been reached
  if(curr_level < goal_level) {
    posUpdate(center_x + radius * cos(new_theta), center_y + radius * sin(new_theta), new_radius, curr_level + 1, theta); 
  }
  
  if(curr_level == goal_level) {
    // Draws arrow from the total of partial sum to where the wave will be visualized
    line(center_x + radius * cos(new_theta), center_y + radius * sin(new_theta), 400, center_y + radius * sin(new_theta));
    line(400, center_y + radius * sin(new_theta), 400 - 10,center_y + radius * sin(new_theta) + 10); 
    line(400, center_y + radius * sin(new_theta), 400 - 10,center_y + radius * sin(new_theta) - 10);  
  }
}

// Draws the resulting wave after every screen clear
public void waveDraw() {
  for(int i = 0; i < 100; i++) {
    point(i + 400, wave[i]);
  }
  
  for(int i = 99; i > 0; i--) {
    wave[i] = wave[i - 1];
  }
  // println(wave);
  
}




// Fourier Series Evaluation
// NEEDS TO BE CHANGED PER SERIES
public float funcEval(float n, float ilevel) {
  return (4 * sin(n * (ilevel * 2 + 1))) / ((ilevel * 2 + 1) * PI);
}

// Returns correct radius for individual level 
// NEEDS TO BE CHANGED PER SERIES
public float amplitude_Max(float ilevel) {
  return abs(4 / ((ilevel * 2 + 1) * PI));
}

// Returns the period of the given partial sum
// NEEDS TO BE CHANGED PER SERIES
public float period_Max(float ilevel) {
  return (abs((2 * PI) / ((ilevel * 2 + 1) * PI)));
}