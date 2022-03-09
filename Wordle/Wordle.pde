import java.util.*;
import java.io.*;

TreeMap<Integer, Integer> dictionary;
TreeMap<Integer, String> words;
TreeMap<String, Integer> letVal = new TreeMap<String, Integer>();
int letters = 5;
boolean guessing = false;
ArrayList<String> guess;
ArrayList<String> colors;
String suggestion = "";
boolean outOfWords = false;
int frameStore = 0;

void setup() {
  size(800, 800);
  guess = new ArrayList<String>();
  colors = new ArrayList<String>();
  BufferedReader reader = createReader("words.txt");
  boolean temp = true;
  words = new TreeMap<Integer, String>();
  int iii = 0;
  while (temp) {
    String line;
    try {
      line = reader.readLine();
    } 
    catch (IOException e) {
      e.printStackTrace();
      line = null;
    }
    if (line == null) {
      temp = false;
    } else {
      if (line.indexOf("1") == -1 && line.indexOf("2") == -1 && line.indexOf("3") == -1 && line.indexOf("4") == -1 && line.indexOf("5") == -1 &&
        line.indexOf("6") == -1 && line.indexOf("7") == -1 && line.indexOf("8") == -1 && line.indexOf("9") == -1 && line.indexOf("0") == -1 &&
        line.indexOf("&") == -1 && line.indexOf(".") == -1) {
        words.put(iii, line);
        iii++;
      }
    }
  }


  for (int ii = 0; ii < words.size(); ii++) {
    String s = words.get(ii);
    for (int i = 0; i < s.length(); i++) {
      String l = s.substring(i, i+1);
      if (letVal.get(l) != null) {
        int get = letVal.get(l);
        letVal.put(l, get+1);
      } else
        letVal.put(l, 1);
    }
  }


  dictionary = new TreeMap<Integer, Integer>();
  int ii = 0;
  for (int j = 0; j < words.size(); j++) {
    String s = words.get(j);
    int score = 0;
    for (int i = 0; i < s.length(); i++) {
      if (s.indexOf(s.substring(i, i+1)) == i)
        score += letVal.get(s.substring(i, i+1));
    }
    dictionary.put(ii, score);
    ii++;
  }
}

void draw() {
  if (!guessing) {
    background(255);
    fill(0);
    textSize(20);
    textAlign(CENTER);
    text("How many letters?", width/2, height/8);
    triangle(300, 150, 350, 150, 325, 200);
    triangle(500, 200, 450, 200, 475, 150);
    fill(255);
    stroke(0);
    rect(360, 130, 80, 100);
    fill(0);
    textSize(50);
    text("" + letters, width/2, height/4);
    fill(20, 200, 20);
    rect(300, 400, 200, 100);
    fill(0);
    text("OK", width/2, 450);
  } else {
    background(255);
    stroke(0);
    for (int i = 0; i < letters; i++) {
      if (colors.get(i).equals("gray"))
        fill(175);
      else if (colors.get(i).equals("yellow"))
        fill(#E5E51E);
      else
        fill(20, 200, 20);
      rect(100 + 600*i/letters, 100, 600/letters, 100);
    }
    fill(0);
    for (int i = 0; i < letters; i++) {
      if (guess.size() > i)
        text(guess.get(i), 100 + 600/letters/2 + 600*i/letters, 160);
    }
    fill(200, 20, 20);
    rect(width/2 - 150, height/2 + 100, 300, 100);
    fill(0);
    text("new word", width/2, height/2 + 150);
    fill(20, 20, 200);
    rect(0, 0, 50, 50);
    fill(0);
    textSize(16);
    text("redo", 25, 25);
    textSize(50);
  }
  if (outOfWords) {
    background(255);
    fill(0);
    text("Out of words", width/2, height/2);
  }
}

void mousePressed() {
  if (!guessing) {
    if (mouseX > 300 && mouseX < 350 && mouseY > 150 && mouseY < 200 && letters > 1)
      letters--;
    if (mouseX > 450 && mouseX < 500 && mouseY > 150 && mouseY < 200)
      letters++;
    if (mouseX > 300 && mouseX < 500 && mouseY > 400 && mouseY < 500) {
      guessing = true;
      for (int i = 0; i < letters; i++)
        colors.add("gray");

      //Removes all words that aren't the right length
      for (int i = 0; i < words.size(); i++) {
        if (words.get(i).length() != letters) {
          dictionary.remove(i);
        } else {
        }
      }

      recommend();

      for (int i = 0; i < letters; i++) {
        guess.add(suggestion.substring(i, i+1));
      }
    }
  } else {
    if (mouseY > 100 && mouseY < 200 && mouseX > 100 && mouseX < 700) {
      int ind = letters*(mouseX-100)/600;
      if (colors.get(ind).equals("gray"))
        colors.set(ind, "yellow");
      else if (colors.get(ind).equals("yellow"))
        colors.set(ind, "green");
      else if (colors.get(ind).equals("green"))
        colors.set(ind, "gray");
    }
    if (mouseX > 250 && mouseX < 550 && mouseY < 600 && mouseY > 500) {
      if (frameCount - frameStore > 10) {
        frameStore = frameCount;
        for (int i = 0; i < words.size(); i++) {
          if (words.get(i).equals(suggestion)) {
            dictionary.remove(i);
          }
        }
        recommend();

        for (int i = 0; i < letters; i++) {
          guess.set(i, suggestion.substring(i, i+1));
        }
      }
    }
    if (mouseX < 50 && mouseY < 50) {
      dictionary = new TreeMap<Integer, Integer>();
      int ii = 0;
      for (int j = 0; j < words.size(); j++) {
        String s = words.get(j);
        int score = 0;
        for (int i = 0; i < s.length(); i++) {
          if (s.indexOf(s.substring(i, i+1)) == i)
            score += letVal.get(s.substring(i, i+1));
        }
        dictionary.put(ii, score);
        ii++;
      }

      //Removes all words that aren't the right length
      for (int i = 0; i < words.size(); i++) {
        if (words.get(i).length() != letters) {
          dictionary.remove(i);
        } else {
        }
      }

      recommend();

      for (int i = 0; i < letters; i++) {
        guess.set(i, suggestion.substring(i, i+1));
      }
    }
  }
}

void keyPressed() {
  if (guessing) {
    if (key == BACKSPACE) {
      if (guess.size() > 0)
        guess.remove(guess.size()-1);
    } else if (key == ENTER) {
      calc();
    } else {
      guess.add(key + "");
    }
  }
}

public void calc() {
  for (int i = 0; i < letters; i++) {
    if (colors.get(i).equals("yellow")) {
      for (int ii = 0; ii < words.size(); ii++) {
        if (dictionary.containsKey(ii) && words.containsKey(ii)) {
          if (words.get(ii).substring(i, i+1).equals(guess.get(i))) {
            dictionary.remove(ii);
            ii--;
          } else {
          }
          if (words.get(ii).indexOf(guess.get(i)) == -1) {
            dictionary.remove(ii);
            ii--;
          }
        }
      }
    } else if (colors.get(i).equals("gray")) {
      boolean temp = true;
      for (int j = 0; j < letters; j++) {
        if (!colors.get(j).equals("gray") && guess.get(j).equals(guess.get(i)))
          temp = false;
      }
      for (int ii = 0; ii < words.size(); ii++) {
        if (dictionary.containsKey(ii) && words.containsKey(ii) && temp) {
          if (words.get(ii).indexOf(guess.get(i)) != -1) {
            dictionary.remove(ii);
            ii--;
          } else {
          }
        }
      }
    } else {
      for (int ii = 0; ii < words.size(); ii++) {
        if (dictionary.containsKey(ii) && words.containsKey(ii)) {
          if (!words.get(ii).substring(i, i+1).equals(guess.get(i))) {
            dictionary.remove(ii);
            ii--;
          } else {
          }
        }
      }
    }
  }

  recommend();

  for (int i = 0; i < letters; i++) {
    guess.set(i, suggestion.substring(i, i+1));
    colors.set(i, "gray");
  }
}

public void recommend() {
  int max = 0;
  boolean temp = true;
  while (temp) {
    if (!dictionary.containsKey(max)) {
      max++;
    } else {
      temp = false;
    }
  }
  suggestion = words.get(max);
  for (int i = 0; i < words.size(); i++) {
    if (dictionary.containsKey(i) ) {
      if (dictionary.get(i) > dictionary.get(max)) {
        suggestion = words.get(i);
        max = i;
      }
    }
  }

  if (dictionary.size() == 0)
    outOfWords = true;
}
