package com.example.stepsleft;

import android.view.View;

/**
 * This class is mainly used inorder to know in what step we currently are in.
 * 
 * @author Jonathan
 *
 */
public class ClickListener {

	int prevStep;

	public ClickListener(final Steps[] steps) {
		steps[0].setOnClickListener(new View.OnClickListener() {

			public void onClick(View v) {
				steps[0].setSelected(true);
				if (steps[prevStep] != steps[0]) {
					steps[prevStep].setSelected(false);
					prevStep = 0;
				}
			}
		});
		steps[1].setOnClickListener(new View.OnClickListener() {

			public void onClick(View v) {
				steps[1].setSelected(true);
				if (steps[prevStep] != steps[1]) {
					steps[prevStep].setSelected(false);
					prevStep = 1;
				}
			}
		});

		steps[2].setOnClickListener(new View.OnClickListener() {

			public void onClick(View v) {
				steps[2].setSelected(true);
				if (steps[prevStep] != steps[2]) {
					steps[prevStep].setSelected(false);
					prevStep = 2;
				}
			}
		});

		steps[3].setOnClickListener(new View.OnClickListener() {

			public void onClick(View v) {
				steps[3].setSelected(true);
				if (steps[prevStep] != steps[3]) {
					steps[prevStep].setSelected(false);
					prevStep = 3;
				}
			}
		});

		steps[4].setOnClickListener(new View.OnClickListener() {

			public void onClick(View v) {
				steps[4].setSelected(true);
				if (steps[prevStep] != steps[4]) {
					steps[prevStep].setSelected(false);
					prevStep = 4;
				}
			}
		});

		steps[5].setOnClickListener(new View.OnClickListener() {

			public void onClick(View v) {
				steps[5].setSelected(true);
				if (steps[prevStep] != steps[5]) {
					steps[prevStep].setSelected(false);
					prevStep = 5;
				}
			}
		});

	}
}
