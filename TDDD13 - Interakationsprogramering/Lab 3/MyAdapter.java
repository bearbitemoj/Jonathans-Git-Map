package com.example.lab3_komponenterochsynkronisering;

import java.util.List;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

public class MyAdapter extends BaseAdapter {

	private List<String> str;
	private Context context;

	public MyAdapter(List<String> str, Context context) {
		// TODO Auto-generated constructor stub
		this.str = str;
		this.context = context;
	}

	/**
	 * Returns the size of the string.
	 */
	@Override
	public int getCount() {
		// TODO Auto-generated method stub
		return str.size();
	}

	/**
	 * Here we get the position for the string object from the list and return it.
	 */
	@Override
	public Object getItem(int position) {
		// TODO Auto-generated method stub
		return str.get(position);
	}

	/**
	 * Gets the Id for the string which is the position of the string object
	 */
	@Override
	public long getItemId(int position) {
		return position;
	}

	/**
	 * Here we create a RowView with each String object from the list and with
	 * the context from MainActivity.
	 */
	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		convertView = new RowView(context, (String) getItem(position));
		return convertView;
	}

}
