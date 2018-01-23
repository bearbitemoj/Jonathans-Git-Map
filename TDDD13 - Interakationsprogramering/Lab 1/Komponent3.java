package com.example.lab1_enklakomponenter;

import android.support.v7.app.ActionBarActivity;
import android.app.ActionBar.LayoutParams;
import android.os.Bundle;
import android.view.Gravity;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.*;

public class Komponent3 extends ActionBarActivity {
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		LinearLayout layout = new LinearLayout(this);
		LinearLayout layout2 = new LinearLayout(this);
		LinearLayout layout3 = new LinearLayout(this);
		LinearLayout layout4 = new LinearLayout(this);
		LinearLayout layout5 = new LinearLayout(this);
		LinearLayout layout6 = new LinearLayout(this);
		LinearLayout layout7 = new LinearLayout(this);
		LinearLayout layout8 = new LinearLayout(this);
		Button button = new Button(this);
		CheckBox checkBox = new CheckBox(this);
		CheckBox checkBox1 = new CheckBox(this);
		CheckBox checkBox2 = new CheckBox(this);
		CheckBox checkBox3 = new CheckBox(this);
		CheckBox checkBox4 = new CheckBox(this);
		CheckBox checkBox5 = new CheckBox(this);
		CheckBox checkBox6 = new CheckBox(this);
		TextView txt = new TextView(this);
		TextView txt2 = new TextView(this);
		TextView txt3 = new TextView(this);
		ImageView img = new ImageView(this);
		
		layout.setOrientation(layout.VERTICAL);
		layout2.setOrientation(layout2.HORIZONTAL);
		layout3.setOrientation(layout3.HORIZONTAL);
		layout4.setOrientation(layout4.HORIZONTAL);
		layout5.setOrientation(layout5.HORIZONTAL);
		layout6.setOrientation(layout6.HORIZONTAL);
		layout7.setOrientation(layout7.HORIZONTAL);
		layout8.setOrientation(layout8.HORIZONTAL);
		
		txt.setText("Hur trivs du på LiU?");
		txt2.setText("Läser du på LiTH?");
		txt3.setText("Är detta LiUs logotyp?");
		button.setText("SKICKA IN");
		checkBox.setText("Bra");
		checkBox1.setText("Mycket Bra");
		checkBox2.setText("Jättebra");
		checkBox3.setText("Ja");
		checkBox4.setText("Nej");
		checkBox5.setText("Ja");
		checkBox6.setText("Nej");
		
		layout.getLayoutParams();
		layout2.getLayoutParams();
		layout4.getLayoutParams();
		layout6.getLayoutParams();
		layout7.getLayoutParams();
		LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT);
		button.setLayoutParams(params);
		txt.setLayoutParams(params);
		txt2.setLayoutParams(params);
		txt3.setLayoutParams(params);
		img.setLayoutParams(params);
		
		img.setImageResource(R.drawable.ic_launcher);
		txt.setGravity(Gravity.CENTER_HORIZONTAL);
		txt2.setGravity(Gravity.CENTER_HORIZONTAL);
		txt3.setGravity(Gravity.CENTER_HORIZONTAL);
		
		layout2.addView(txt);
		layout.addView(layout2);
		layout3.addView(checkBox);
		layout3.addView(checkBox1);
		layout3.addView(checkBox2);
		layout.addView(layout3);
		layout4.addView(txt2);
		layout.addView(layout4);
		layout5.addView(checkBox3);
		layout5.addView(checkBox4);
		layout.addView(layout5);
		layout6.addView(img);
		layout.addView(layout6);
		layout7.addView(txt3);
		layout.addView(layout7);
		layout8.addView(checkBox5);
		layout8.addView(checkBox6);
		layout.addView(layout8);
		layout.addView(button);
		
		setContentView(layout);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
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
