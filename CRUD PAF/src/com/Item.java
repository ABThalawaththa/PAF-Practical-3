package com;

import java.sql.*;

public class Item {
	public Connection connect() {
		Connection con = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3308/test", "root", "");
			// For testing
			System.out.print("Successfully connected");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return con;
	}
	
	public static void main(String args[]) {
		Item item = new Item();
		if(item.connect() != null) {
			System.out.println("Fuck you");
		}
	}

}
