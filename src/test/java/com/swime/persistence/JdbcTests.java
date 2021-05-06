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
		System.setProperty("oracle.jdbc.fanEnabled","false");
		System.setProperty("oracle.net.tns_admin","/Users/sinseonggwon/Wallet_swime/");
		try(Connection con =
				DriverManager.getConnection(
						"jdbc:log4jdbc:oracle:thin:@swime_tp",
						"ADMIN",
						"1q2w3e4r5t6Y")){
            log.info(con);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
	//로컬
//	@Test
//	public void testConnection() {
//
//		try (Connection con = DriverManager.getConnection(
//				"jdbc:oracle:thin:@localhost:1521:XE",
//				"book_ex",
//				"1234")){
//			log.info(con);
//		}catch(Exception e) {
//			fail(e.getMessage());
//		}
//	}
//}

