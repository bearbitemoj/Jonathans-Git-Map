package com.example.lab1_enklakomponenter;

import android.support.v7.app.ActionBarActivity;
import android.app.ActionBar.LayoutParams;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.*;

public class Komponent2 extends ActionBarActivity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		LinearLayout layout = new LinearLayout(this);
		LinearLayout layout2 = new LinearLayout(this);
		LinearLayout layout3 = new LinearLayout(this);
		LinearLayout layout4 = new LinearLayout(this);
		LinearLayout layout5 = new LinearLayout(this);
		TextView txt = new TextView(this);
		TextView txt2 = new TextView(this);
		TextView txt3 = new TextView(this);
		TextView txt4 = new TextView(this);
		EditText editText = new EditText(this);
		EditText editText2 = new EditText(this);
		EditText editText3 = new EditText(this);
		SeekBar seekbar = new SeekBar(this);
		
		layout.setOrientation(layout.VERTICAL);
		layout2.setOrientation(layout2.HORIZONTAL);
		layout3.setOrientation(layout3.HORIZONTAL);
		layout4.setOrientation(layout4.HORIZONTAL);
		layout5.setOrientation(layout5.HORIZONTAL);
		
		txt.setText("Namn");
		txt2.setText("Lösenord");
		txt3.setText("Epost");
		txt4.setText("Ålder");
		
		layout2.getLayoutParams();
		layout3.getLayoutParams();
		layout4.getLayoutParams();
		layout5.getLayoutParams();
		LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT);
		editText.setLayoutParams(params);
		editText2.setLayoutParams(params);
		editText3.setLayoutParams(params);
		seekbar.setLayoutParams(params);
		
		layout2.addView(txt);
		layout2.addView(editText);
		layout.addView(layout2);
		layout3.addView(txt2);
		layout3.addView(editText2);
		layout.addView(layout3);
		layout4.addView(txt3);
		layout4.addView(editText3);
		layout.addView(layout4);
		layout5.addView(txt4);
		layout5.addView(seekbar);
		layout.addView(layout5);
		
		setContentView(layout);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main_activity3, menu);
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
