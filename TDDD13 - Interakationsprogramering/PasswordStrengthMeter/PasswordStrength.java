package com.example.passwordstrengthmeter;

import android.content.Context;
import android.graphics.Color;
import android.widget.EditText;

/**
 * This class handles all the algorithms and sends the data for what strength a
 * string is directly to the class StrengthMeter
 * 
 * @author Jonathan and Nikolas
 *
 */
public class PasswordStrength extends EditText {

	protected final String alphabet = "abcdefghijklmnopqrstuvwxyzåäö";
	protected final String alphabet2 = "ABCDEFGHIJKLMNOPQRSTUVWXYZÅÄÖ";
	protected final String number = "0123456789";
	protected final String specialChar = "½§!@#£¤<>$%&,*^=?/+-._";
	private boolean lowerCase = false;
	private boolean upperCase = false;

	int count1 = 0;
	int count2 = 0;
	int count3 = 0;
	int count4 = 0;
	int count5 = 0;
	StrengthMeter strmeter;

	int tooShortColor = Color.BLACK;
	int weekColor = Color.MAGENTA;
	int fairColor = Color.RED;
	int goodColor = Color.YELLOW;
	int greatColor = Color.CYAN;
	int strongColor = Color.GREEN;

	String tooShortLabel = "Too Short";
	String weekLabel = "Week";
	String fairLabel = "Fair";
	String goodLabel = "Good";
	String greatLabel = "Great";
	String strongLabel = "Strong";

	Criteria crit;

	/**
	 * @param strmeter
	 *            is the instance of the StrengthMeter
	 */
	public PasswordStrength(Context context) {
		super(context);
		this.strmeter = new StrengthMeter(context);
	}

	/**
	 * Here the strength is set by going through each char in the text and
	 * checks if it fulfills certain criteria and when a strength is calculated
	 * the method colorStrength is contacted that will set the draw values.
	 * 
	 * @param text
	 *            is the text that has been written
	 */
	public void setStrength(String text) {
		int strength = 0;
		int criterias = 5;
		if (text.length() >= 8) {
			for (int i = 0; i < text.length(); i++) {
				if (criteriaLetter(text, i) && count1 < 1) {
					count1 = 1;
					strength++;
				}
				if (criteriaNumber(text, i) && count2 < 1) {
					count2 = 1;
					strength++;
				}
				if (criteriaSpecial(text, i) && count3 < 1) {
					count3 = 1;
					strength++;
				}
				if (criteriaLong(text) && count4 < 1) {
					count4 = 1;
					strength++;
				}
				if (crit != null) {
					if (crit.newCriteria(text, i) && count5 < 1) {
						count5 = 1;
						strength++;
						criterias++;
					}
				}
			}
			resetCriterias();
		}
		if (text.length() > 0 && text.length() < 8) {
			strength = 1;
		} else if (text.length() >= 8) {
			strength += 2;
		}
		colorStrength((double) strength / criterias);
	}

	/**
	 * Here is the criteria for which the string contains both upperCase and
	 * lowerCase letters
	 * 
	 * @param text
	 *            is the String
	 * @param i
	 * @return true or false depending on if the criteria is fulfilled or not.
	 */
	private boolean criteriaLetter(String text, int i) {
		for (int j = 0; j < alphabet.length(); j++) {
			if (text.charAt(i) == alphabet.charAt(j)) {
				lowerCase = true;
			}
			if (text.charAt(i) == alphabet2.charAt(j)) {
				upperCase = true;
			}
		}
		if (upperCase && lowerCase) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * Here is the criteria for which the string contains numbers
	 * 
	 * @param text
	 *            is the String
	 * @param i
	 * @return true or false depending on if the criteria is fulfilled or not.
	 */
	private boolean criteriaNumber(String text, int i) {
		boolean hasNumber = false;
		for (int j = 0; j < number.length(); j++) {
			if (text.charAt(i) == number.charAt(j)) {
				hasNumber = true;
			}
		}
		return hasNumber;
	}

	/**
	 * Here is the criteria for which the string contains special characters
	 * like: !"#¤%&@" and so on
	 * 
	 * @param text
	 *            is the String
	 * @param i
	 * @return true or false depending on if the criteria is fulfilled or not.
	 */
	private boolean criteriaSpecial(String text, int i) {
		boolean hasSpecialChar = false;
		for (int j = 0; j < specialChar.length(); j++) {
			if (text.charAt(i) == specialChar.charAt(j)) {
				hasSpecialChar = true;
			}
		}
		return hasSpecialChar;
	}

	/**
	 * Here is the criteria for which the string is at least 12 characters long
	 * 
	 * @param text
	 *            is the String
	 * @return true or false depending on if the criteria is fulfilled or not.
	 */
	private boolean criteriaLong(String text) {
		if (text.length() >= 12) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * Sets the attributes for what should be drawn depending on password
	 * strength
	 * 
	 * @param strength
	 */
	private void colorStrength(double strength) {
		if (strength == 0) {
			strmeter.setMeter(Color.GRAY, 1.00, "");
		}
		if (strength > 0 && strength <= 0.2) {
			strmeter.setMeter(tooShortColor, 0.2, tooShortLabel);
		}
		if (strength > 0.2 && strength <= 0.4) {
			strmeter.setMeter(weekColor, 0.40, weekLabel);
		}
		if (strength > 0.4 && strength <= 0.6) {
			strmeter.setMeter(fairColor, 0.6, fairLabel);
		}
		if (strength > 0.6 && strength <= 0.8) {
			strmeter.setMeter(goodColor, 0.8, goodLabel);
		}
		if (strength > 0.8 && strength <= 1) {
			strmeter.setMeter(strongColor, 1.00, strongLabel);
		}
	}

	/**
	 * Sets the color for each strength
	 * 
	 * @param color1
	 * @param color2
	 * @param color3
	 * @param color4
	 * @param color5
	 * @param color6
	 */
	public void setColors(int color1, int color2, int color3, int color4,
			int color5) {
		if (color1 != 0) {
			tooShortColor = color1;
		}
		if (color2 != 0) {
			weekColor = color2;
		}
		if (color3 != 0) {
			fairColor = color3;
		}
		if (color4 != 0) {
			goodColor = color4;
		}
		if (color5 != 0) {
			strongColor = color5;
		}
	}

	/**
	 * Sets the label for each strength
	 * 
	 * @param label1
	 * @param label2
	 * @param label3
	 * @param label4
	 * @param label5
	 * @param label6
	 */
	public void setLabels(String label1, String label2, String label3,
			String label4, String label5) {
		if (label1 != null) {
			tooShortLabel = label1;
		}
		if (label2 != null) {
			weekLabel = label2;
		}
		if (label3 != null) {
			fairLabel = label3;
		}
		if (label4 != null) {
			goodLabel = label4;
		}
		if (label5 != null) {
			strongLabel = label5;
		}
	}

	/**
	 * Resets all the criterias
	 */
	private void resetCriterias() {
		lowerCase = false;
		upperCase = false;

		count1 = 0;
		count2 = 0;
		count3 = 0;
		count4 = 0;
		count5 = 0;
	}

	public void addCriteria(Criteria crit) {
		this.crit = crit;
	}

}
