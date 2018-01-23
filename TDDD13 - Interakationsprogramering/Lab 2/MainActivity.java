package com.example.lab2_komplexakomponenter;

import android.app.Activity;
import android.graphics.Color;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.*;

public class MainActivity extends Activity {

	private MyAdapter adapter = new MyAdapter(this);
	private int prevIndex = -1;
	private ExpandableListView explist;
	private EditText text;
	private boolean clicked = false;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		LinearLayout layout = new LinearLayout(this);
		text = new EditText(this);
		explist = new ExpandableListView(this);
		explist.setAdapter(adapter);

		text.setText("/");

		explist.setOnGroupExpandListener(new ExpandableListView.OnGroupExpandListener() {
			int previousItem = -1;

			/**
			 * onGroudExpand is used to collapse a previous used group
			 */
			@Override
			public void onGroupExpand(int groupPosition) {
				if (groupPosition != previousItem)
					explist.collapseGroup(previousItem);
				previousItem = groupPosition;
			}

		});

		explist.setOnGroupClickListener(new ExpandableListView.OnGroupClickListener() {
			int prevParrent = -1;

			/**
			 * onGroupClick is used to set the text in my EditText to show in
			 * which group, if any, i'm in.
			 */
			@Override
			public boolean onGroupClick(ExpandableListView parent, View v,
					int groupPosition, long id) {
				clicked = true;

				if (groupPosition != prevParrent) {
					text.setText("/" + adapter.getGroup(groupPosition));
					prevParrent = groupPosition;
				} else {
					prevParrent = -1;
					text.setText("/");
				}
				return false;
			}
		});

		explist.setOnChildClickListener(new ExpandableListView.OnChildClickListener() {

			@Override
			/**
			 * onChildClick marks the child I click on and also writes the path to the child in my EditText
			 * It also unmarks the previous child if I mark a new one
			 */
			public boolean onChildClick(ExpandableListView parent, View v,
					int groupPosition, int childPosition, long id) {
				int index = parent.getFlatListPosition(ExpandableListView
						.getPackedPositionForChild(groupPosition, childPosition));
				clicked = true;
				try {
					BackgroundTransparent(parent, prevIndex);
					parent.getChildAt(index).setBackgroundColor(Color.BLUE);
				} catch (Exception e) {
					System.out.println(e);
				}
				text.setText("/"
						+ adapter.getGroup(groupPosition)
						+ "/"
						+ adapter.getChild(groupPosition, childPosition)
								.toString());
				prevIndex = index;
				return false;
			}
		});

		text.addTextChangedListener(new TextWatcher() {
			@Override
			public void afterTextChanged(Editable s) {
				update(s);
			}

			@Override
			public void onTextChanged(CharSequence s, int start, int before,
					int count) {
			}

			@Override
			public void beforeTextChanged(CharSequence s, int start, int count,
					int after) {
			}

		});

		layout.setOrientation(LinearLayout.VERTICAL);
		layout.getLayoutParams();

		layout.addView(text);
		layout.addView(explist);

		setContentView(layout);
	}

	/**
	 * The update method updates everything that happens after I have changed a
	 * text. It expands the group I search for, the group where the child is and
	 * marks the child as well It has an variable called "clicked" that makes
	 * sure that I don't interact with the expandGroup and collapseGroup
	 * commands I use This also makes it possible to swift between clicking and
	 * writing without any interferences
	 * 
	 * @param s
	 *            is the text I edit
	 */
	private void update(Editable s) {
		String[] parentL = adapter.parentList;
		String[][] childL = adapter.childList;
		boolean foundWord = false;
		int index = 0;

		if (clicked == false) {
			for (int i = 0; i < parentL.length; i++) {
				for (int j = 0; j <= adapter.getChildrenCount(i) - 1; j++) {
					if (("/" + childL[i][j]).contains(s)
							|| s.length() == 0
							|| ("/").contentEquals(s)
							|| ("/" + parentL[i] + "/" + childL[i][j])
									.contains(s)) {
						if (s.length() == 0) {
							text.setText("/");
						}
						foundWord = true;
						try {
							index = explist
									.getFlatListPosition(ExpandableListView
											.getPackedPositionForChild(i, j));
							if (s.length() > 1) {
								explist.expandGroup(i);
							} else {
								explist.collapseGroup(i);
							}

							if ((("/" + childL[i][j]).contentEquals(s) || ("/"
									+ parentL[i] + "/" + childL[i][j])
										.contentEquals(s)) && s.length() > 1) {
								explist.getChildAt(index).setBackgroundColor(
										Color.BLUE);
							} else {
								BackgroundTransparent(explist, index);
							}
						} catch (Exception e) {
							System.out.println(e);
						}
						text.setBackgroundColor(Color.WHITE);
					} else if (!foundWord) {
						text.setBackgroundColor(Color.RED);
					}
				}
				if (foundWord == false) {
					explist.collapseGroup(i);
				}
			}
		} else {
			clicked = false;
		}
		prevIndex = index;

	}

	/**
	 * Used to set the background of a child to transparent as long as the child
	 * exists
	 * 
	 * @param exp
	 *            : ExpandableListView
	 * @param index
	 *            : the position of the child
	 */
	private void BackgroundTransparent(ExpandableListView exp, int index) {
		if (index >= 0) {
			exp.getChildAt(index).setBackgroundColor(Color.TRANSPARENT);
		}
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

		// noinspection SimplifiableIfStatement
		if (id == R.id.action_settings) {
			return true;
		}

		return super.onOptionsItemSelected(item);
	}
}
