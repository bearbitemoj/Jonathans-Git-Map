package com.example.lab3_komponenterochsynkronisering;

import android.support.v7.app.ActionBarActivity;
import android.text.Editable;
import android.text.TextWatcher;
import android.graphics.Color;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.*;
import android.widget.AdapterView.OnItemClickListener;

public class MainActivity extends ActionBarActivity {

	/**
	 * Here is the layout created together with everything in it.
	 */
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		LinearLayout Layout = new LinearLayout(this);
		final MyInteractiveSearcher mis = new MyInteractiveSearcher(this);
		final Button button = new Button(this);

		mis.addTextChangedListener(new TextWatcher() {

			@Override
			public void onTextChanged(CharSequence s, int start, int before,
					int count) {

			}

			@Override
			public void beforeTextChanged(CharSequence s, int start, int count,
					int after) {
			}

			/**
			 * Here a query made is whenever the text is changed. If there is no
			 * text the listpopupwindow will close.
			 */
			@Override
			public void afterTextChanged(Editable s) {
				try {
					if (s.length() > 0) {
						mis.makeQuery();
					} else {
						mis.lpw.dismiss();
					}
				} catch (Exception e) {
					button.setText("I'm sorry but you have no internt connection!");
				}
			}
		});

		/**
		 * If a view is clicked on in the listpopupwindow then the text will be
		 * written in the EditText.
		 */
		mis.lpw.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> parent, View view,
					int position, long id) {
				mis.setText(mis.list.get(position));
			}
		});

		Layout.setOrientation(LinearLayout.VERTICAL);
		Layout.getLayoutParams();

		mis.setBackgroundColor(Color.GREEN);
		button.setTextColor(Color.WHITE);
		button.setText("Test");
		button.setBackgroundColor(Color.BLACK);

		Layout.addView(mis);
		Layout.addView(button);
		setContentView(Layout);
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
