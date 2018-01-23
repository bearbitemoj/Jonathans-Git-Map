package com.example.passwordstrengthmeter;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Rect;
import android.view.View;

/**
 * Here the Strengthmeter is drawn with certain attributes depending on the
 * strength of the password.
 * 
 * @author Jonathan and Nikolas
 *
 */
public class StrengthMeter extends View {

	Rect tempRec;
	int color;
	public double width = 1;
	String text;

	public StrengthMeter(Context context) {
		super(context);
	}

	/**
	 * Sets the Strenghtmeters color, width and a text with it.
	 * 
	 * @param color
	 *            of the strengthmeter
	 * @param width
	 *            of the strengthmeter
	 * @param text
	 *            for the strengthmeter
	 */
	public void setMeter(int color, double width, String text) {
		this.color = color;
		this.width = width;
		this.text = text;
	}

	/**
	 * Draws two rectangles where one is a standard for background if no string
	 * is written and another for when something is written that overlaps the
	 * other one.
	 */
	protected void onDraw(Canvas canvas) {
		super.onDraw(canvas);
		Rect rec = new Rect();
		rec.set(0, 0, canvas.getWidth(), 20);

		Rect tempRec = new Rect();
		tempRec.set(0, 0, (int) (canvas.getWidth() * width), 20);

		Paint paint = new Paint();
		paint.setColor(Color.GRAY);

		Paint tempPaint = new Paint();
		tempPaint.setColor(color);
		try {
			canvas.drawRect(rec, paint);
			canvas.drawRect(tempRec, tempPaint);
			tempPaint.setTextSize(30);
			canvas.drawText(text, 10, 50, tempPaint);
		} catch (Exception e) {
		}
		invalidate();
	}
}
