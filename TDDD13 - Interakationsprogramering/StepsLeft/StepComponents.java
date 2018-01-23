package com.example.stepsleft;

import java.util.Vector;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Typeface;
import android.view.ViewGroup.LayoutParams;
import android.widget.TextView;

public class StepComponents extends TextView {

	Vector<Steps> LinkedList = new Vector<Steps>();
	Context context;
	
	public StepComponents(Context context) {
		super(context);
		this.context = context;
		setTextSize(30);
		setTypeface(null, Typeface.BOLD);
		setText("Your Steps");
	}
	
	public void addStep(int color, String text){
		int number = LinkedList.size()+1;
		Steps step = new Steps(context, color, text, number);
		LinkedList.add(step);
	}
	
	public void removeStep(){
		if(LinkedList.size()>0){
			LinkedList.remove(LinkedList.size()-1);
		}
	}
	
	public Steps getStep(int i){
		return LinkedList.get(i);
	}
	
	public int getNumberOfSteps(){
		return LinkedList.size();
	}
	
	public void setSelected(int location){
		for(int i = 0; i<LinkedList.size(); i++){
			if(i != location){
				LinkedList.get(i).setSelected(false);
			}else{
				LinkedList.get(i).setSelected(true);
			}
		}
		LinkedList.get(location).setSelected(true);
	}
	
	protected void onDraw(Canvas canvas) {
		super.onDraw(canvas);
		for(int i = 0; i<LinkedList.size(); i++){
			LinkedList.get(i).onDraw(canvas);
		}
		invalidate();
	}
	
	@Override
	protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec){
		super.onMeasure(widthMeasureSpec, heightMeasureSpec);
		setMeasuredDimension(LayoutParams.MATCH_PARENT, 90*LinkedList.size()+40);
	}
}
