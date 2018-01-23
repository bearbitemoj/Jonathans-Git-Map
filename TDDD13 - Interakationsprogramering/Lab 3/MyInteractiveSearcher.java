package com.example.lab3_komponenterochsynkronisering;

import java.util.ArrayList;

import android.content.Context;
import android.view.ViewGroup.LayoutParams;
import android.widget.EditText;
import android.widget.ListPopupWindow;

/**
 * Here is where the interactiveSearcher handles everything. It creates a query
 * and updates the listpopupwindow.
 * 
 * @author Jonathan and Nikolas
 * 
 */
public class MyInteractiveSearcher extends EditText {

	NetWork thread; // thread for doing the task

	ArrayList<String> list;
	private Context context;
	public ListPopupWindow lpw; // for displaying the popup

	/**
	 * I get the context from the mainActivity and creates a listpopupwindow.
	 * 
	 * @param context
	 *            from the activity
	 */
	public MyInteractiveSearcher(Context context) {
		super(context);
		this.context = context;
		lpw = new ListPopupWindow(context);
	}

	/**
	 * Creates a NetWork that is running in a thread in order not to freeze the
	 * UI while getting the network information.
	 */
	public void makeQuery() {
		thread = new NetWork(this, this.getText(), context);
		thread.start();
	}

	/**
	 * Here the UI is updated with the current list. An adapter is created
	 * in order to specify what information is in the listpopupwindow.
	 * 
	 * @param viewList
	 *            is the list which contains the information taken from the
	 *            website.
	 */
	public void updateUI(ArrayList<String> viewList) {
		MyAdapter adapter = new MyAdapter(viewList, context);
		this.list = viewList;

		lpw.setAnchorView(this);
		lpw.setAdapter(adapter);
		lpw.setWidth(LayoutParams.MATCH_PARENT);
		lpw.setVerticalOffset(5);
		lpw.setHeight(300);
		lpw.show();
	}

}
