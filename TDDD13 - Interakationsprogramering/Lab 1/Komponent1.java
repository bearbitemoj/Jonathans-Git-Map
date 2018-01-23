package com.example.lab1_enklakomponenter;

import android.support.v7.app.ActionBarActivity;
import android.annotation.SuppressLint;
import android.app.ActionBar.LayoutParams;
import android.os.Bundle;
import android.view.Gravity;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.*;

public class Komponent1 extends ActionBarActivity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		LinearLayout layout1 = new LinearLayout(this);
		RatingBar rating = new RatingBar(this);
		Button button = new Button(this);
		EditText txt = new EditText(this);
		EditText txt2 = new EditText(this);
		
		layout1.setOrientation(layout1.VERTICAL);
		
		layout1.getLayoutParams();
		LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT);
		button.setLayoutParams(params);
		LinearLayout.LayoutParams params2 = new LinearLayout.LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);
		rating.setLayoutParams(params2);
		LinearLayout.LayoutParams params3 = new LinearLayout.LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.FILL_PARENT);
		txt2.setLayoutParams(params3);
		button.setText("Knapp");
		
		layout1.addView(button);
		layout1.addView(txt);
		layout1.addView(rating);
		layout1.addView(txt2);
		
		setContentView(layout1);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main_activity2, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		// Handle action bar item clicks here. The action bar will
		// automatically handle clicks on the Home/Up button, so long
		// as you specify a parent activity in AndroidManifest.xml.
		int id = item.getItemId();
		if (id == R.id.action_settings) {
			return true;
		}
		return super.onOptionsItemSelected(item);
	}
}
