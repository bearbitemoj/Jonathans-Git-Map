package com.example.lab3_komponenterochsynkronisering;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.view.View;
import android.view.ViewGroup.LayoutParams;

/**
 * The RowView is the view for which each String is represented in the
 * listpopupwindow.
 * 
 * @author Jonathan and Nikolas
 *
 */
public class RowView extends View {

	private String name;
	private Paint paint = null;
	private int size = 30;

	/**
	 * 
	 * @param context
	 *            is the mainActivity context
	 * @param name
	 *            is the name of the string object that should be drawn
	 */
	public RowView(Context context, String name) {
		super(context);
		this.name = name;
		paint = new Paint();
		paint.setColor(Color.RED);

	}

	/**
	 * Here the text is drawn with a size and color.
	 */
	@Override
	protected void onDraw(Canvas canvas) {
		// TODO Auto-generated method stub
		super.onDraw(canvas);
		paint.setTextSize(size);
		canvas.drawText(name, 0, size, paint);
	}

	/**
	 * onMeasure tells Android how big you want your custom view to be dependent
	 * the layout constraints provided by the parent. Since we draw in a
	 * listpopupwindow each String object needs to have a specified parent that
	 * they can draw in or else it won't know the size of the parent and nothing
	 * will be drawn.
	 */
	@Override
	protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
		// TODO Auto-generated method stub
		super.onMeasure(widthMeasureSpec, heightMeasureSpec);
		setMeasuredDimension(LayoutParams.MATCH_PARENT, size + 10);
	}

}