package com.swime.persistence;

import lombok.extern.log4j.Log4j;
import org.junit.Test;

import java.sql.Connection;
import java.sql.DriverManager;

import static org.junit.Assert.fail;

@Log4j
public class JdbcTests {
    static {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");

        }catch(Exception e) {
            e.printStackTrace();
        }
    }


	@Test
	public void testConnection() {
		try(Connection con =
				DriverManager.getConnection(
						"jdbc:oracle:thin:@swime.cuhd6k7lvd6s.us-east-2.rds.amazonaws.com:1521:ORCL",
						"admin",
						"1q2w3e4r")){
            log.info(con);
		}catch(Exception e) {
			e.printStackTrace();
		}

	}
}

