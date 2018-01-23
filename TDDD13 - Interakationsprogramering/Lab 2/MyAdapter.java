package com.example.lab2_komplexakomponenter;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;

public class MyAdapter extends BaseExpandableListAdapter {

	private Context context;
	public String[] parentList = { "Nintendo", "Xbox", "Playstation", "Pc", "Nintendo" };
	public String[][] childList = { { "Mario", "Zelda", "Metroid", "Indies" },
			{ "Halo", "CoD", "GoW" },
			{ "Uncharted", "LBP", "Killzone" }, { "Bioshock" }, {"Mario", "Zelda", "Metroid", "hi"}};

	public MyAdapter(Context context) {
		this.context = context;
	}

	@Override
	public int getGroupCount() {
		// TODO Auto-generated method stub
		return parentList.length;
	}

	@Override
	public int getChildrenCount(int groupPosition) {
		return childList[groupPosition].length;
	}

	@Override
	public Object getGroup(int groupPosition) {
		return parentList[groupPosition];
	}

	@Override
	public Object getChild(int groupPosition, int childPosition) {
		// TODO Auto-generated method stub
		return childList[groupPosition][childPosition];
	}

	@Override
	public long getGroupId(int groupPosition) {
		// TODO Auto-generated method stub
		return groupPosition;
	}

	@Override
	public long getChildId(int groupPosition, int childPosition) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public boolean hasStableIds() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public View getGroupView(int groupPosition, boolean isExpanded,
			View convertView, ViewGroup parent) {
		TextView txt = new TextView(context);
		txt.setText(parentList[groupPosition]);
		txt.setPadding(50, 0, 0, 0);
		txt.setTextSize(15);
		return txt;
	}

	@Override
	public View getChildView(int groupPosition, int childPosition,
			boolean isLastChild, View convertView, ViewGroup parent) {
		TextView txt = new TextView(context);
		txt.setText(childList[groupPosition][childPosition]);
		txt.setPadding(80, 0, 0, 0);
		txt.setTextSize(15);
		return txt;
	}

	@Override
	public boolean isChildSelectable(int groupPosition, int childPosition) {
		// TODO Auto-generated method stub
		return true;
	}

}
