package com.example.stepsleft;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.view.View;
import android.view.ViewGroup.LayoutParams;

/**
 * Creates a Step with a certain text, Color and Step-number.
 * @author Jonathan
 *
 */
public class Steps extends View {

	int color;
	Context context;
	String text;
	int number;
	boolean selected = false;

	/**
	 * @param context the MainActivity
	 * @param color for the Step
	 * @param text for the Step
	 * @param number for the Step
	 */
	public Steps(Context context, int color, String text, int number) {
		super(context);
		this.context = context;
		this.color = color;
		this.text = text;
		this.number = number;
	}

	/**
	 * Draws the step with a certain color, Text and Step-number
	 */
	protected void onDraw(Canvas canvas) {
		super.onDraw(canvas);
		Paint paint = new Paint();
		paint.setColor(color);
		try {
			int radie = 40;
			int paddingY = number*2*radie+10*number;
			canvas.drawCircle(radie + 10, paddingY, radie, paint);
			if (selected) {
				paint.setColor(Color.BLACK);
				paint.setFakeBoldText(true);
			} else {
				paint.setColor(Color.GRAY);
				paint.setFakeBoldText(false);
			}
			paint.setTextSize(30);
			canvas.drawText(text, radie * 2 + 40,paddingY + 10, paint);
			paint.setColor(Color.WHITE);
			paint.setFakeBoldText(true);
			paint.setTextSize(35);
			canvas.drawText(String.valueOf(number), radie,paddingY + 10, paint);
		} catch (Exception e) {
		}
	}

	/**
	 * Makes the Step selected or not.
	 */
	public void setSelected(boolean selected) {
		this.selected = selected;
	}
	
	/**
	 * Define the layoutParams for each step here.
	 */
	@Override
	protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec){
		super.onMeasure(widthMeasureSpec, heightMeasureSpec);
		setMeasuredDimension(LayoutParams.MATCH_PARENT, 90*number+40);
	}
}
