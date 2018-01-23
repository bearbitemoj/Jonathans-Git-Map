package com.example.stepsleft;

import android.support.v7.app.ActionBarActivity;
import android.graphics.Color;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.*;

/**
 * Here is the layout for each step created where in each Step we can specify
 * our own Text and Color and which step it is.
 * 
 * @author Jonathan and Nikolas
 *
 */
public class MainActivity extends ActionBarActivity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		LinearLayout layout = new LinearLayout(this);
		LinearLayout layout2 = new LinearLayout(this);
		Button btn = new Button(this);
		Button btn2 = new Button(this);
		
		final StepComponents stepComp = new StepComponents(this);

		stepComp.addStep(Color.YELLOW, "Choose the Plan");
		stepComp.addStep(Color.MAGENTA, "Login & Mail");
		stepComp.addStep(Color.RED, "Complete your infos!");
		stepComp.addStep(Color.CYAN, "Subscription period");
//		stepComp.addStep(Color.BLUE, "Review your order!");
		stepComp.addStep(Color.GREEN, "Procedd to paypal");

		layout.setOrientation(LinearLayout.VERTICAL);
		
		//These buttons are only here in order to test the stepComponent
		btn.setText("Remove");
		btn.setOnClickListener(new OnClickListener() {
			
			public void onClick(View v) {
				stepComp.removeStep();
			}
		});
		
		btn2.setText("Switch Selected");
		btn2.setOnClickListener(new View.OnClickListener() {
			
			int n = 0;
			@Override
			public void onClick(View v) {
				if(n >= stepComp.getNumberOfSteps()){
					n = 0;
				}
				stepComp.setSelected(n);
				n++;
			}
		});
		
		layout2.addView(btn);
		layout2.addView(btn2);

		layout.addView(stepComp);
		layout.addView(layout2);

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
