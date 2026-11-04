
Table moodData;

void setup() {
  size(800, 540);
  background(255);

  moodData = loadTable("mood_data.csv", "header");

  // Project title
  fill(30);
  textSize(24);
  text("100 Moments of Me", 30, 40);

  // Subtitle
  textSize(13);
  text("Each circle represents one mood observation", 30, 65);

  // Observation counter
  textSize(14);
  text(moodData.getRowCount() + " / 100 observations", 30, 95);

  // Progress bar
  noFill();
  stroke(180);
  rect(30, 108, 200, 12);

  float progress = moodData.getRowCount() / 100.0;

  fill(60, 180, 100);
  noStroke();
  rect(30, 108, 200 * progress, 12);

  // Draw mood observations
  for (int i = 0; i < moodData.getRowCount(); i++) {
    int intensity = moodData.getInt(i, "Intensity");
    String emotion = moodData.getString(i, "Emotion");

    String dayLabel = moodData.getString(i, "Day");
    String time = moodData.getString(i, "Time");

    String[] dayParts = split(dayLabel, " ");
    int dayNumber = int(dayParts[1]);

    String[] timeParts = split(time, ":");
    int hour = int(timeParts[0]);
    int minute = int(timeParts[1]);

    float timeValue = hour + minute / 60.0;

    float x = map(timeValue, 7, 23, 40, 520);
    float y = map(dayNumber, 1, 8, 170, 460);

    int circleSize = calculateSize(intensity);

    fill(getEmotionColour(emotion));
    noStroke();
    ellipse(x, y, circleSize, circleSize);
  }

  // Time labels
  fill(30);
  textSize(12);
  text("07:00", 40, 505);
  text("12:00", 190, 505);
  text("17:00", 340, 505);
  text("23:00", 490, 505);
  text("Time of day", 250, 525);

  // Day labels
  for (int day = 1; day <= 8; day++) {
    text("Day " + day, 5, 175 + (day - 1) * 41);
  }

  drawLegend();
  drawIntensityKey();
}

int calculateSize(int intensity) {
  return intensity * 10;
}

color getEmotionColour(String emotion) {
  if (emotion.equals("Happy")) {
    return color(255, 220, 0);
  } else if (emotion.equals("Sad")) {
    return color(70, 130, 220);
  } else if (emotion.equals("Stressed")) {
    return color(220, 60, 60);
  } else if (emotion.equals("Calm")) {
    return color(60, 180, 100);
  } else if (emotion.equals("Excited")) {
    return color(255, 140, 0);
  } else if (emotion.equals("Tired")) {
    return color(140, 100, 180);
  } else {
    return color(230, 120, 160);
  }
}

void drawLegend() {
  String[] emotions = {
    "Happy", "Sad", "Stressed", "Calm",
    "Excited", "Tired", "Irritated"
  };

  textSize(14);
  fill(30);
  text("Emotion key", 550, 85);

  for (int i = 0; i < emotions.length; i++) {
    fill(getEmotionColour(emotions[i]));
    ellipse(560, 110 + i * 28, 15, 15);

    fill(30);
    text(emotions[i], 580, 115 + i * 28);
  }
}

void drawIntensityKey() {
  fill(30);
  textSize(14);
  text("Mood intensity", 550, 340);

  for (int i = 1; i <= 5; i++) {
    int circleSize = i * 5;

    fill(100, 100, 100);
    noStroke();

    float circleY = 365 + (i - 1) * 24;

    ellipse(560, circleY, circleSize, circleSize);

    fill(30);
    text("Level " + i, 590, circleY + 5);
  }
}
