package com.example.lab3_komponenterochsynkronisering;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.json.JSONArray;
import org.json.JSONObject;

import android.app.Activity;
import android.content.Context;
import android.text.Editable;

/**
 * Here is where the information is loaded from the website and transformed into
 * a String list.
 * 
 * @author Jonathan & Nikolas
 */
public class NetWork extends Thread {

	private Editable input;
	private MyInteractiveSearcher myIntSearch;
	private Context context;

	/**
	 * The run method is immediately contacted when the thread starts. Here we
	 * first get the information from the website, transforms it from JSONObject
	 * to String and put it in a list.
	 * When the list is created the thread contacts the updateUI.
	 */
	@Override
	public void run() {
		super.run();
		String json = doNetworkCall();
		String[] names = parseJSON(json);
		final ArrayList<String> viewList = new ArrayList<String>();
		boolean remove = true;
		try {
			for (int i = 0; i < names.length; i++) {
				if (names[i].startsWith(input.toString().toUpperCase())
						&& input.length() > 0) {
					viewList.add(names[i]);
					remove = false;
				} else if (remove) {
					viewList.remove(names[i]);
				}
				remove = true;
			}

			((Activity) context).runOnUiThread(new Runnable() {

				@Override
				public void run() {
					myIntSearch.updateUI(viewList);
				}
			});

		} catch (Exception e) {
		}
	}

	public NetWork(MyInteractiveSearcher myIntSearcher, Editable text,
			Context context) {
		this.myIntSearch = myIntSearcher;
		this.input = text;
		this.context = context;
	}

	/**
	 * Transforms the JSONObject string into a String list.
	 * @param json is the form the website information is in.
	 * @return the list of Strings from the website.
	 */
	public String[] parseJSON(String json) {
		try {
			JSONObject jo = new JSONObject(json);
			JSONArray jarray = jo.getJSONArray("result");
			String[] list = new String[jarray.length()];
			for (int i = 0; i < jarray.length(); i++) {
				list[i] = jarray.getString(i);
			}
			return list;
		} catch (Exception e) {
			return null;
		}
	}

	private String doNetworkCall() {
		try {
			DefaultHttpClient httpclient = new DefaultHttpClient();
			HttpGet httpget = new HttpGet(
					"http://flask-afteach.rhcloud.com/getnames/3/"
							+ input.toString());
			HttpResponse response = null;
			response = httpclient.execute(httpget);

			BufferedReader in = new BufferedReader(new InputStreamReader(
					response.getEntity().getContent()));
			StringBuffer sb = new StringBuffer("");
			String line = "";
			String NL = System.getProperty("line.separator");
			while ((line = in.readLine()) != null) {
				sb.append(line + NL);
			}
			in.close();
			String json = sb.toString();
			return json;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "";
	}
}
