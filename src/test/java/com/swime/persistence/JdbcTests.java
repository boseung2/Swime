package com.swime.persistence;

import org.junit.Test;

import java.sql.Connection;
import java.sql.DriverManager;

import static org.junit.Assert.fail;

public class JdbcTests {
    static {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
			//oracle.jdbc.driver.OracleDriver
        }catch(Exception e) {
            e.printStackTrace();
        }
    }


	@Test
	public void testConnection() {
		try(Connection con =
				DriverManager.getConnection(
						"jdbc:oracle:thin:@aiaclassi1.iptime.org:3000:XE",
						"swime",
						"1234")){
            System.out.println(con);;
		}catch(Exception e) {
			e.printStackTrace();
		}

	}
}

