package com.example.passwordstrengthmeter;

import android.support.v7.app.ActionBarActivity;
import android.text.Editable;
import android.text.InputType;
import android.text.TextWatcher;
import android.graphics.Color;
import android.graphics.Typeface;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.ViewGroup.LayoutParams;
import android.widget.*;

/**
 * In the MainActivity are the layouts created with the appropriate TextViews
 * and an EditText. The classes PasswordStrength that handles the algorithms and
 * the class StrengthMeter that handles the draw are also created here.
 * 
 * @author Jonathan and Nikolas
 *
 */
public class MainActivity extends ActionBarActivity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		LinearLayout layout = new LinearLayout(this);
		LinearLayout layout1 = new LinearLayout(this);
		LinearLayout layout2 = new LinearLayout(this);
		LinearLayout layout3 = new LinearLayout(this);
		TextView txtv = new TextView(this);
		final TextView txtv2 = new TextView(this);
		final PasswordStrength passwstr = new PasswordStrength(this);
		
		passwstr.setColors(Color.BLUE, 0, 0, 0, 0);

		layout.setOrientation(LinearLayout.VERTICAL);
		layout.getLayoutParams();
		@SuppressWarnings("deprecation")
		LayoutParams params = new LayoutParams(LayoutParams.FILL_PARENT,
				LayoutParams.WRAP_CONTENT);
		passwstr.setLayoutParams(params);
		layout1.setOrientation(LinearLayout.HORIZONTAL);
		layout1.getLayoutParams();
		layout2.setOrientation(LinearLayout.HORIZONTAL);
		layout2.getLayoutParams();
		layout3.setOrientation(LinearLayout.VERTICAL);
		layout3.getLayoutParams();

		txtv.setTypeface(null, Typeface.BOLD);
		txtv.setText("Choose a password: ");
		txtv2.setPadding(200, 0, 0, 0);
		txtv2.setText("Minimum of 8 character in length.");
		passwstr.setInputType(InputType.TYPE_CLASS_TEXT
				| InputType.TYPE_TEXT_VARIATION_PASSWORD);

		passwstr.addTextChangedListener(new TextWatcher() {

			@Override
			public void onTextChanged(CharSequence s, int start, int before,
					int count) {
			}

			@Override
			public void beforeTextChanged(CharSequence s, int start, int count,
					int after) {
			}

			/**
			 * Here we set the strength of the password in regard to the text
			 * that has been written.
			 */
			@Override
			public void afterTextChanged(Editable s) {
				passwstr.setStrength(s.toString());
			}
		});
		
		passwstr.addCriteria(new Criteria() {

			@Override
			public boolean newCriteria(String text, int i) {
				if (text.length() >= 14) {
					return true;
				} else {
					return false;
				}
			}
		});
		
		layout1.addView(txtv);
		layout1.addView(passwstr);
		layout2.addView(txtv2);
		layout3.addView(passwstr.strmeter);

		layout.addView(layout1);
		layout.addView(layout2);
		layout.addView(layout3);
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
